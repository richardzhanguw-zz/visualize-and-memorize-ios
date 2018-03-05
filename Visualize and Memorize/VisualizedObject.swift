//
//  VisualizedObject.swift
//  Visualize and Memorize
//
//  Created by Richard Zhang on 2018-03-01.
//  Copyright © 2018 Richard Zhang. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class VisualizedObject  {
    var image: UIImage!
    var imageName: String!
    var objectName: String!
    var fileManager: FileManager!
    init(withImage image: UIImage, andObjectName objectName: String) {
        self.image = image
        self.objectName = objectName
    }
    
    init(withImageName imageName: String?, andObjectName objectName: String) {
        self.imageName = imageName
        self.fileManager = FileManager.default
        do {
            let directory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
            let url = directory.appendingPathComponent(self.imageName)
            self.image = UIImage(contentsOfFile: url.path)
        } catch {
            fatalError(error.localizedDescription)
        }
        self.objectName = objectName
        self.fileManager = FileManager.default
    }
    
    func saveImage() {
        do {
            let directory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
            let url = directory.appendingPathComponent(self.objectName! + "_test")
            if let jpegRepresentation = UIImageJPEGRepresentation(self.image, 1.0) {
                try jpegRepresentation.write(to: url)
            }
            let container = NSPersistentContainer(name: "CoreData")
            container.loadPersistentStores { (description, error) in
                if let error = error {
                    fatalError(error.localizedDescription)
                }
            }
            let context = container.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "CDVisualizedObject", in: context)
            let newVisualizedObject = NSManagedObject(entity: entity!, insertInto: context)
            newVisualizedObject.setValue(self.objectName, forKey: "objectName")
            newVisualizedObject.setValue(self.objectName! + "_test", forKey: "imageName")
            do {
                try context.save()
            } catch {
                print(error)
            }
            
        } catch {
            print(error)
        }
        
    }
    
}
