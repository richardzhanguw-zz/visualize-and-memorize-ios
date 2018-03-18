//
//  ViewController.swift
//  Visualize and Memorize
//
//  Created by Richard Zhang on 2018-02-11.
//  Copyright © 2018 Richard Zhang. All rights reserved.
//

import UIKit
import ARKit
import SceneKit
import Vision
import AVFoundation

class ObjectIdentifierCameraViewController: UIViewController, ARSCNViewDelegate, AVSpeechSynthesizerDelegate {
    
    var arView: ARSCNView!
    var requests = [VNRequest]()
    var mostRecentLocation : String = "none"
    var currentlyDisplayedObjectName = ""
    var ttsButton: RoundButton!
    var identifyNewObjectButton: RoundButton!
    var saveCurrentObjectButton: RoundButton!
    var nodeCount = 0
    var mostRecentVisualizedObject: VisualizedObject!
    
    let customDispatchQueue = DispatchQueue(label: "Custom Dispatch Queue")
    let arSceneConfig = ARWorldTrackingConfiguration()
    let speaker = AVSpeechSynthesizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        speaker.delegate = self
        guard let mlModel = try? VNCoreMLModel(for: Resnet50().model) else {
            fatalError("Model does not exist")
        }
        let request = VNCoreMLRequest(model: mlModel, completionHandler: coreMLcompletionHandler)
        request.imageCropAndScaleOption = VNImageCropAndScaleOption.centerCrop
        requests = [request]
        refreshScreen()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        arView.session.run(arSceneConfig)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        arView.session.pause()
    }
    
    func refreshScreen() {
        customDispatchQueue.async {
            self.refreshScreen()
            let pixelBuffer : CVPixelBuffer? = (self.arView.session.currentFrame?.capturedImage)
            let ciImage = pixelBuffer == nil ? nil : CIImage(cvPixelBuffer: pixelBuffer!)
            let imgReqHandler = ciImage == nil ? nil : VNImageRequestHandler(ciImage: ciImage!, options: [:])
            if let reqHandler = imgReqHandler{
                do {
                    try reqHandler.perform(self.requests)
                } catch {
                    print(error)
                }
            }
        }
    }
    
    func createLocationNode(withLocationName locationName : String) -> SCNNode {

        let depth = CGFloat(0.02)
        let constraints = [SCNBillboardConstraint()]
        constraints[0].freeAxes = SCNBillboardAxis.Y
        let text = SCNText(string: locationName, extrusionDepth: depth)
        let wrapperBubbleNode = SCNNode()
        text.chamferRadius = CGFloat(0.02)
        text.alignmentMode = kCAAlignmentCenter
        text.font = UIFont(name: "Courier-Bold", size: 0.1)
        text.firstMaterial?.diffuse.contents = UIColor.blue
        let textNode = SCNNode(geometry: text)
        textNode.scale = SCNVector3Make(0.15, 0.15, 0.15)
        textNode.pivot = SCNMatrix4MakeTranslation( (text.boundingBox.max.x - text.boundingBox.min.x)/2, text.boundingBox.min.y, Float(depth))
        wrapperBubbleNode.addChildNode(textNode)
        wrapperBubbleNode.constraints = constraints
        return wrapperBubbleNode
    }
    
    func coreMLcompletionHandler(request: VNRequest, error: Error?) {
        let classification = request.results == nil ? nil : request.results![0] as? VNClassificationObservation
        if let classification = classification {
            DispatchQueue.main.async {
                let firstGuess = classification.identifier.components(separatedBy: ",")
                self.mostRecentLocation = firstGuess[0]
            }
        } else {
            if let errorThrown = error {
                fatalError(errorThrown.localizedDescription)
            }
        }
    }
    
    func setupUI() {
        navigationItem.title = "Visualize"
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        var identifyNewObjectButtonFrame: CGRect
        if #available(iOS 11.0, *), let keyWindow = UIApplication.shared.delegate!.window! {
             arView = ARSCNView(frame: CGRect(x: keyWindow.safeAreaInsets.left, y: (navigationController?.navigationBar.frame.maxY)!, width: view.frame.width, height: view.frame.height - keyWindow.safeAreaInsets.top - keyWindow.safeAreaInsets.bottom))
            identifyNewObjectButtonFrame = CGRect(x: view.frame.width/2 - 35, y: view.frame.height - keyWindow.safeAreaInsets.bottom - 80.0, width: 70, height: 70)
        } else {
             arView = ARSCNView(frame: CGRect(x: 0, y: view.safeAreaInsets.top, width: view.frame.width, height: view.frame.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom))
            identifyNewObjectButtonFrame = CGRect(x: view.frame.width/2, y: view.frame.height - 80.0, width: 70, height: 70)
        }
        view.addSubview(arView)
        arView.delegate = self
        arView.scene = SCNScene()
        arSceneConfig.planeDetection = .horizontal
        var ttsButtonFrame: CGRect
        var saveCurrentObjectButtonFrame: CGRect
        ttsButtonFrame = CGRect(x: identifyNewObjectButtonFrame.maxX + 10 , y: identifyNewObjectButtonFrame.minY, width: 70, height: 70 )
        saveCurrentObjectButtonFrame = CGRect(x: identifyNewObjectButtonFrame.minX - 80.0, y: identifyNewObjectButtonFrame.minY , width: 70, height: 70 )
        ttsButton = RoundButton(withFrame:ttsButtonFrame , andButtonColour: UIColor.red, andImage: UIImage(named: "Volume Mute")!)
        identifyNewObjectButton = RoundButton(withFrame:identifyNewObjectButtonFrame , andButtonColour: UIColor.green, andImage: UIImage(named: "Add")!)
        saveCurrentObjectButton = RoundButton(withFrame: saveCurrentObjectButtonFrame, andButtonColour: UIColor.blue, andImage: UIImage(named: "Save Object")!)
        ttsButton.addTarget(self, action: #selector(onSpeakButtonClicked), for: .touchUpInside)
        identifyNewObjectButton.addTarget(self, action: #selector(onIdentifyNewObjectButtonClicked), for: .touchUpInside)
        saveCurrentObjectButton.addTarget(self, action: #selector(onSaveCurrentObjectButtonClicked), for: .touchUpInside)
        view.addSubview(identifyNewObjectButton)
        view.addSubview(ttsButton)
        view.addSubview(saveCurrentObjectButton)
    }
    
    func speak(withPhrase phrase: String){
        let utterance = AVSpeechUtterance(string: phrase)
        speaker.speak(utterance)
    }
    
    @objc func onSpeakButtonClicked(){
        if (currentlyDisplayedObjectName != "") {
            ttsButton.setImage(UIImage(named: "Volume Up"), for: UIControlState.normal)
            speak(withPhrase: currentlyDisplayedObjectName)
        }
    }
    
    @objc func onSaveCurrentObjectButtonClicked(){
        if let visualizedObject = mostRecentVisualizedObject {
            self.navigationController?.pushViewController(SaveObjectViewController(withVisualizedObject: visualizedObject) , animated: true)
        }
    }
    
    @objc func onIdentifyNewObjectButtonClicked(){
        let hitTestResults = arView.hitTest( CGPoint(x: arView.frame.midX, y: arView.frame.midY), types: [.featurePoint])
        guard let firstHitTestResult = hitTestResults.first else {
            return
        }
        if (nodeCount == 1) {
            return
        } else {
            nodeCount += 1
        }
        let worldTransform = firstHitTestResult.worldTransform
        let realLifeCoordinate = SCNVector3Make(worldTransform.columns.3.x, worldTransform.columns.3.y, worldTransform.columns.3.z)
        let node : SCNNode = createLocationNode(withLocationName: mostRecentLocation)
        currentlyDisplayedObjectName = mostRecentLocation
        mostRecentVisualizedObject = VisualizedObject(withImage: arView.snapshot(), andObjectName: currentlyDisplayedObjectName)
        arView.scene.rootNode.addChildNode(node)
        node.position = realLifeCoordinate
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        ttsButton.setImage(UIImage(named: "Volume Mute"), for: UIControlState.normal)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {

    }
}



