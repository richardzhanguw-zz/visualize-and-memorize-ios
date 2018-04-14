//
//  VisualizedObjectMoreInfoViewController.swift
//  Visualize and Memorize
//
//  Created by Richard Zhang on 2018-03-10.
//  Copyright © 2018 Richard Zhang. All rights reserved.
//

import Foundation
import UIKit
import AVKit

class VisualizedObjectMoreInfoViewController: UIViewController, AVSpeechSynthesizerDelegate {
    
    var visualizedObjectImageView: UIImageView!
    var visualizedObjectInfoLabel: UILabel!
    var visualizedObject: VisualizedObject!
    var ttsButton: RoundButton!

    let speaker = AVSpeechSynthesizer()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    init(withVisualizedObject object: VisualizedObject) {
        super.init(nibName: nil, bundle: nil)
        visualizedObject = object
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(nibName: nil, bundle: nil)
    }
    
    func setupUI(){
        speaker.delegate = self
        let backButton = UIBarButtonItem()
        var ttsButtonFrame: CGRect
        backButton.title = "Back"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        view.backgroundColor = UIColor.white
        if let keyWindow = UIApplication.shared.delegate!.window! {
            visualizedObjectImageView = UIImageView(frame: CGRect(x: 0, y: (navigationController?.navigationBar.frame.maxY)!, width: view.frame.width, height: view.frame.height - (navigationController?.navigationBar.frame.maxY)! - keyWindow.safeAreaInsets.bottom - 100))
            ttsButtonFrame = CGRect(x: view.frame.width - 80 , y: view.frame.height - (navigationController?.navigationBar.frame.maxY)! - keyWindow.safeAreaInsets.bottom, width: 70, height: 70 )
        } else {
            visualizedObjectImageView = UIImageView(frame: CGRect(x: 0, y: (navigationController?.navigationBar.frame.maxY)!, width: view.frame.width, height: view.frame.height - (navigationController?.navigationBar.frame.maxY)! - 100))
            ttsButtonFrame = CGRect(x: view.frame.width - 80 , y: view.frame.height - 80, width: 70, height: 70 )
        }
        ttsButton = RoundButton(withFrame:ttsButtonFrame , andButtonColour: UIColor.red, andImage: UIImage(named: "Volume Mute")!)
        ttsButton.addTarget(self, action: #selector(onTTSButtonClicked), for: .touchUpInside)
        visualizedObjectImageView.image = visualizedObject.image
        visualizedObjectInfoLabel = UILabel(frame: CGRect(x: 0, y: visualizedObjectImageView.frame.maxY, width: view.frame.width, height: 100))
        visualizedObjectInfoLabel.text = visualizedObject.objectName
        visualizedObjectInfoLabel.textAlignment = .center
        view.addSubview(visualizedObjectImageView)
        view.addSubview(visualizedObjectInfoLabel)
        view.addSubview(ttsButton)
    }
    
    @objc func onTTSButtonClicked() {
        ttsButton.setImage(UIImage(named: "Volume Up"), for: UIControlState.normal)
        speak(withPhrase: visualizedObject.objectName!)
        
    }
    
    func speak(withPhrase phrase: String){
        let utterance = AVSpeechUtterance(string: phrase)
        speaker.speak(utterance)
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        ttsButton.setImage(UIImage(named: "Volume Mute"), for: UIControlState.normal)
    }
}
