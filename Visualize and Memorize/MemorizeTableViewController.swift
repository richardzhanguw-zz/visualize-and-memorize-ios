//
//  MemorizeTableViewController.swift
//  Visualize and Memorize
//
//  Created by Richard Zhang on 2018-02-28.
//  Copyright © 2018 Richard Zhang. All rights reserved.
//

import Foundation
import UIKit


class MemorizeTableViewController: UITableViewController {
    
    var visualizedObjects: [VisualizedObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fileManager = FileStorageManager()
        visualizedObjects = fileManager.getVisualizedObjects()
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return visualizedObjects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let cell = MemorizeTableViewCell(withTitle: visualizedObjects[index].objectName, andImage: visualizedObjects[index].image)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
