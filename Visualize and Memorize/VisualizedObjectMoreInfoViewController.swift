//
//  VisualizedObjectMoreInfoViewController.swift
//  Visualize and Memorize
//
//  Created by Richard Zhang on 2018-03-10.
//  Copyright © 2018 Richard Zhang. All rights reserved.
//

import Foundation
import UIKit

class VisualizedObjectMoreInfoViewController: UIViewController {
    
    var visualizedObjectImageView: UIImageView!
    var visualizedObjectInfoLabel: UILabel!
    var visualizedObject: VisualizedObject!
    
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
        view.backgroundColor = UIColor.white
        if #available(iOS 11.0, *), let keyWindow = UIApplication.shared.delegate!.window! {
            visualizedObjectImageView = UIImageView(frame: CGRect(x: 0, y: (navigationController?.navigationBar.frame.maxY)!, width: view.frame.width, height: view.frame.height - (navigationController?.navigationBar.frame.maxY)! - keyWindow.safeAreaInsets.bottom - 100))
            visualizedObjectImageView.image = visualizedObject.image
            visualizedObjectInfoLabel = UILabel(frame: CGRect(x: 0, y: visualizedObjectImageView.frame.maxY, width: view.frame.width, height: 100))
            visualizedObjectInfoLabel.text = visualizedObject.objectName
            visualizedObjectInfoLabel.textAlignment = .center
            view.addSubview(visualizedObjectImageView)
            view.addSubview(visualizedObjectInfoLabel)
        }
    }
}
