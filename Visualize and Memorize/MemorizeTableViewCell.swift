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
    fileprivate lazy var rowPicture: UIImageView = {
        let rowPicture = UIImageView(frame: CGRect(x: 10, y: 10, width: 60, height: 60))
        return rowPicture
    } ()
    fileprivate lazy var rowTitle: UILabel = {
        let rowTitle = UILabel()
        let frame = CGRect(x: rowPicture.frame.maxX + 40, y: 20, width: 0, height: 0)
        rowTitle.frame = frame
        return rowTitle
    } ()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func update(withTitle title: String, andImage image: UIImage? ) {
        rowPicture.image = image
        
        rowTitle.text = title
        rowTitle.sizeToFit()
        
        self.contentView.addSubview(rowPicture)
        self.contentView.addSubview(rowTitle)
    }
}
