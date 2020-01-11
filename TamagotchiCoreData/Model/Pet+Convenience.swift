//
//  Pet+Convenience.swift
//  TamagotchiCoreData
//
//  Created by Madison Kaori Shino on 1/11/20.
//  Copyright © 2020 HaleyJones. All rights reserved.
//

import Foundation
import CoreData

extension Pet {
    @discardableResult
    convenience init(name: String, timeSinceFed: Date, hunger: Int64, happiness: Int64, context: NSManagedObjectContext = CoreDataStack.managedObjectContext) {
        self.init(context: context)
        self.name = name
        self.timeSinceFed = timeSinceFed
        self.hunger = hunger
        self.happiness = happiness
    }
}
