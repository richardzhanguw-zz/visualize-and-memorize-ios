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

class ViewController: UIViewController, ARSCNViewDelegate, AVSpeechSynthesizerDelegate {
    
    var arView: ARSCNView!
    var requests = [VNRequest]()
    var mostRecentLocation : String = "none"
    
    let customDispatchQueue = DispatchQueue(label: "Custom Dispatch Queue")
    let arSceneConfig = ARWorldTrackingConfiguration()
    let speaker = AVSpeechSynthesizer()
    var ttsButton: UIButton!
    
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            let worldCoord : SCNVector3 = SCNVector3Make(0.0 ,0.0, -0.2)
            let node : SCNNode = self.createLocationNode(withLocationName: self.mostRecentLocation)
            self.arView.scene.rootNode.addChildNode(node)
            node.position = worldCoord
        })
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
        let text = SCNText(string: locationName, extrusionDepth: depth)
        let wrapperBubbleNode = SCNNode()
        text.chamferRadius = CGFloat(0.02)
        text.alignmentMode = kCAAlignmentCenter
        text.font = UIFont(name: "Courier-Bold", size: 0.1)
        let textNode = SCNNode(geometry: text)
        textNode.scale = SCNVector3Make(0.1, 0.1, 0.1)
        textNode.pivot = SCNMatrix4MakeTranslation( (text.boundingBox.max.x - text.boundingBox.min.x)/2, text.boundingBox.min.y, Float(depth))
        wrapperBubbleNode.addChildNode(textNode)
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
        arView = ARSCNView(frame: CGRect(x: 0, y: self.view.safeAreaInsets.top, width: self.view.frame.width, height: self.view.frame.height - self.view.safeAreaInsets.top - self.view.safeAreaInsets.bottom))
        self.view.addSubview(arView)
        arView.delegate = self
        arView.scene = SCNScene()
        arSceneConfig.planeDetection = .horizontal
        ttsButton = UIButton(frame: CGRect(x: self.view.frame.width - 80.0, y: self.view.frame.height - self.view.safeAreaInsets.top - 80.0  , width: 70, height: 70))
        ttsButton.layer.cornerRadius = ttsButton.frame.width/2
        ttsButton.clipsToBounds = true
        ttsButton.setImage(UIImage(named: "Volume Mute"), for: UIControlState.normal)
        ttsButton.addTarget(self, action: #selector(self.onSpeakButtonClicked), for: .touchUpInside)
        ttsButton.backgroundColor = UIColor.red
        self.view.addSubview(ttsButton)
    }
    
    func speak(withPhrase phrase: String){
        let utterance = AVSpeechUtterance(string: phrase)
        speaker.speak(utterance)
    }
    
    @objc func onSpeakButtonClicked(){
        ttsButton.setImage(UIImage(named: "Volume Up"), for: UIControlState.normal)
        self.speak(withPhrase: self.mostRecentLocation)
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        ttsButton.setImage(UIImage(named: "Volume Mute"), for: UIControlState.normal)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        
    }
}



