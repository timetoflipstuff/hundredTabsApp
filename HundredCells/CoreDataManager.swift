//
//  CoreDataManager.swift
//  HundredCells
//
//  Created by Alex Mikhaylov on 04/12/2019.
//  Copyright © 2019 Pink Team. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    public static let shared = CoreDataManager()
    
    private let stack = CoreDataStack.shared
    
}

extension CoreDataManager {
    
    public func saveImage(id: Int16, tab: Data, full: Data) {
        stack.persistentContainer.performBackgroundTask { (context) in
            let image = MOImage(context: context)
            image.id = id
            image.tab = tab
            image.full = full
            do {
                try context.save()
            } catch {
                print("Image save failed: \(error)")
            }
        }
    }
    
    public func getFetchedResultsController() -> NSFetchedResultsController<MOImage> {
        let context = stack.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<MOImage>(entityName: "Image")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                    managedObjectContext: context,
                                                    sectionNameKeyPath: nil,
                                                    cacheName: nil)
        do {
            try controller.performFetch()
        } catch {
            fatalError("Failed to fetch entities: \(error)")
        }
        return controller
    }
    
}
