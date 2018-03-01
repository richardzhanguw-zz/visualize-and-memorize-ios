//
//  HomeTableViewController.swift
//  Visualize and Memorize
//
//  Created by Richard Zhang on 2018-02-24.
//  Copyright © 2018 Richard Zhang. All rights reserved.
//

import Foundation
import UIKit

class HomeTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Visualize and Memorize"
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.tableView.isScrollEnabled = false
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: HomeTableViewCell = HomeTableViewCell()
        if (indexPath.row == 0) {
            cell = HomeTableViewCell(withText: "Visualize")
        } else if (indexPath.row == 1) {
            cell = HomeTableViewCell(withText: "Memorize")
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0) {
            self.navigationController?.pushViewController(ObjectIdentifierCameraViewController(), animated: true)
        } else if (indexPath.row == 1){
            self.navigationController?.pushViewController(MemorizeTableViewController(), animated: true)
        }
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}
