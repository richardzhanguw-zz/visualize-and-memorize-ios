//
//  HomeTableViewCell.swift
//  Visualize and Memorize
//
//  Created by Richard Zhang on 2018-02-25.
//  Copyright © 2018 Richard Zhang. All rights reserved.
//

import Foundation
import UIKit

class HomeTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {

    }
    
}
