//
//  RoundButton.swift
//  Visualize and Memorize
//
//  Created by Richard Zhang on 2018-02-24.
//  Copyright © 2018 Richard Zhang. All rights reserved.
//

import Foundation
import UIKit

class RoundButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(withFrame frame: CGRect, andButtonColour buttonColour: UIColor, andImage image: UIImage) {
        super.init(frame:frame)
        layer.cornerRadius = self.frame.width/2
        clipsToBounds = true
        setImage(image, for: UIControlState.normal)
        backgroundColor = buttonColour
    }
    
}
