//
//  MemorizeTableViewCell.swift
//  Visualize and Memorize
//
//  Created by Richard Zhang on 2018-02-28.
//  Copyright © 2018 Richard Zhang. All rights reserved.
//

import Foundation
import UIKit

class MemorizeTableViewCell: UITableViewCell {
    //currently a static cell until stored data can be retrieved
    var rowPicture: UIImageView!
    var rowTitle: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(withTitle title: String, andImage image: UIImage? ) {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: nil)
        rowPicture = UIImageView(frame: CGRect(x: 10, y: 10, width: 60, height: 60))
        rowPicture.backgroundColor = UIColor.red
        
        rowTitle = UILabel(frame: CGRect(x: self.contentView.frame.width - 80, y: 10, width: 0, height: 0))
        rowTitle.text = title
        rowTitle.sizeToFit()
        
        
        self.contentView.addSubview(rowPicture)
        self.contentView.addSubview(rowTitle)
        
    }
}
