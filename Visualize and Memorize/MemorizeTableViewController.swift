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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fileManager = FileStorageManager()
        let x = fileManager.getVisualizedObjects()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MemorizeTableViewCell(withTitle: "Row Title", andImage: UIImage())
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
