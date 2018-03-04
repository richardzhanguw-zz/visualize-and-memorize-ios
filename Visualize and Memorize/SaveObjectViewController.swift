//
//  SaveObjectViewController.swift
//  Visualize and Memorize
//
//  Created by Richard Zhang on 2018-03-02.
//  Copyright © 2018 Richard Zhang. All rights reserved.
//

import Foundation
import UIKit

class SaveObjectViewController: UIViewController {
    
    var visualizedObject: VisualizedObject!
    var objectImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        objectImageView = UIImageView(image: visualizedObject.image)
        objectImageView.frame = self.view.frame
        view.addSubview(self.objectImageView)
    }
    
    init(withVisualizedObject object: VisualizedObject) {
        super.init(nibName: nil, bundle: nil)
        visualizedObject = object
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(nibName: nil, bundle: nil)
        setupUI()
    }
    
    func setupUI() {
        visualizedObject.saveImage()
    }
}
