//
//  CoreDataStack.swift
//  HundredCells
//
//  Created by Alex Mikhaylov on 04/12/2019.
//  Copyright © 2019 Pink Team. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    static let shared = CoreDataStack()
    
    public let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "DataModel")
        let group = DispatchGroup()
        group.enter()
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
            group.leave()
        }
        group.wait()
    }
    
}
