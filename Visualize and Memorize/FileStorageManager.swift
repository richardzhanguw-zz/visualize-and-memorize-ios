//
//  FileStorageManager.swift
//  Visualize and Memorize
//
//  Created by Richard Zhang on 2018-03-01.
//  Copyright © 2018 Richard Zhang. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class FileStorageManager {
    
    init() {
        
    }
    
    func store(visualizedObject: VisualizedObject) {
        
    }
    
    func getVisualizedObjects() -> [VisualizedObject] {
        var cdVisualizedObjects  = [NSManagedObject]()
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError(error.localizedDescription)
            }
        }
        let context = container.viewContext
        var fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDVisualizedObject")
        do {
            cdVisualizedObjects = try context.fetch(fetchRequest) as! [NSManagedObject]
        } catch {
            print(error)
        }
        return [VisualizedObject]()
    }
}
