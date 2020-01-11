//
//  PetController.swift
//  TamagotchiCoreData
//
//  Created by Madison Kaori Shino on 1/11/20.
//  Copyright © 2020 HaleyJones. All rights reserved.
//

import Foundation
import CoreData

class PetController {
    
    //MARK: - Singleton & Source of Truth
    static let sharedInstance = PetController()

    //MARK: - Fetch
    var fetchedResultController: NSFetchedResultsController<Pet>
    
    init() {
        let request: NSFetchRequest<Pet> = Pet.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "timeSinceFed", ascending: true)]
        let resultsController: NSFetchedResultsController<Pet> = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataStack.managedObjectContext, sectionNameKeyPath: "timeSinceFed", cacheName: nil)
        fetchedResultController = resultsController
        do {
            try fetchedResultController.performFetch()
        } catch {
            print("Error performing fetch request")
        }
    }
    
    //MARK: - CRUD
    
    func createPet(withName name: String) {
        _ = Pet(name: name, timeSinceFed: Date(), hunger: 50, happiness: 50)
        saveToPersistentStore()
    }
    
    func updatePet() {
        
    }
    
    func setPetFree() {
        
    }
    
    func setAllPetsFree() {
        
    }
    
    //MARK: - Persistence
    func saveToPersistentStore() {
        do {
            try CoreDataStack.managedObjectContext.save()
        } catch {
            print("Error Saving to Persistent Store", error.localizedDescription)
        }
    }
}
