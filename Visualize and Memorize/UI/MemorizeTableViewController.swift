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
    
    fileprivate lazy var visualizedObjects: [VisualizedObject] = {
        let visualizedObjects = FileStorageManager.getVisualizedObjects()
        return visualizedObjects
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        navigationItem.title = "Memorize"
        tableView.allowsMultipleSelectionDuringEditing = false
        tableView.register(MemorizeTableViewCell.self, forCellReuseIdentifier: "Regular Cell")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return visualizedObjects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "Regular Cell") as! MemorizeTableViewCell
        cell.update(withTitle: visualizedObjects[index].objectName, andImage: visualizedObjects[index].image)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(VisualizedObjectMoreInfoViewController(withVisualizedObject: visualizedObjects[indexPath.row]), animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let object = visualizedObjects.remove(at: indexPath.row)
            FileStorageManager.delete(visualizedObject: object)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}
