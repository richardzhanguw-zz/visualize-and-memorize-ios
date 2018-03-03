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
        self.view.backgroundColor = UIColor.white
        self.objectImageView = UIImageView(image: visualizedObject.image)
        self.objectImageView.frame = self.view.frame
        self.view.addSubview(self.objectImageView)
    }
    
    init(withVisualizedObject object: VisualizedObject) {
        super.init(nibName: nil, bundle: nil)
        self.visualizedObject = object
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(nibName: nil, bundle: nil)
        self.setupUI()
    }
    
    func setupUI() {
    }
}
