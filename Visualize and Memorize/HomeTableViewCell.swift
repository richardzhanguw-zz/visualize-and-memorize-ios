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
    
    var label: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(withText text: String) {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: nil)
        label = UILabel(frame: CGRect(x: self.contentView.bounds.size.width/2 - 50, y: self.contentView.bounds.size.height/2, width: 100, height: 40))
        label.text = text
        label.font = label.font.withSize(36)
        label.textAlignment = .center
        label.sizeToFit()
        self.contentView.addSubview(label)
    }
    
    
}
