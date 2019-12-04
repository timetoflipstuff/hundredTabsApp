//
//  MOImage.swift
//  HundredCells
//
//  Created by Alex Mikhaylov on 04/12/2019.
//  Copyright © 2019 Pink Team. All rights reserved.
//

import Foundation
import CoreData

@objc(MOImage)
final class MOImage: NSManagedObject {
    
    @NSManaged var id: Int16
    @NSManaged var tab: Data
    @NSManaged var full: Data
    
}
