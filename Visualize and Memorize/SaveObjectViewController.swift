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
    
    fileprivate var visualizedObject: VisualizedObject?
    fileprivate lazy var objectImageView: UIImageView = {
        return UIImageView()
    } ()
    
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
    
    func setupUI() {
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        objectImageView.image  = visualizedObject?.image
        
        if #available(iOS 11.0, *), let keyWindow = UIApplication.shared.delegate!.window! {
            let frame = CGRect(x: keyWindow.safeAreaInsets.left, y: (navigationController?.navigationBar.frame.maxY)!, width: view.frame.width, height: view.frame.height - keyWindow.safeAreaInsets.top - keyWindow.safeAreaInsets.bottom)
            objectImageView.frame = frame
        } else {
            objectImageView.frame = view.frame
        }
        let saveButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.plain, target: self, action: #selector(saveObjectImage))
        navigationItem.rightBarButtonItem = saveButtonItem
        view.addSubview(objectImageView)
    }
    
    @objc func saveObjectImage() {
        visualizedObject?.saveImage()
        self.navigationController?.popToRootViewController(animated: true)
    }
}
