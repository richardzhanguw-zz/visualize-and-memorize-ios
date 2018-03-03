//
//  VisualizedObject.swift
//  Visualize and Memorize
//
//  Created by Richard Zhang on 2018-03-01.
//  Copyright © 2018 Richard Zhang. All rights reserved.
//

import Foundation
import UIKit

class VisualizedObject {
    var image: UIImage!
    var objectName: String!
    
    init(withImage image: UIImage, andObjectName objectName: String) {
        self.image = image
        self.objectName = objectName
    }
    
}
