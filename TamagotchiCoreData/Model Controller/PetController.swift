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
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        let resultsController: NSFetchedResultsController<Pet> = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataStack.managedObjectContext, sectionNameKeyPath: "name", cacheName: nil)
        fetchedResultController = resultsController
        do {
            try fetchedResultController.performFetch()
        } catch {
            print("Error performing fetch request")
        }
    }
    
    //MARK: - CRUD
    func createPet(withName name: String) {
        _ = Pet(name: name, timeLastFed: Date(), timeLastPet: Date(), hunger: 50, happiness: 50)
        saveToPersistentStore()
    }
    
    func updateStats(forPet pet: Pet){
        let currentDate = Date()
        guard let petLastFed = pet.timeLastFed,
            let petLastPet = pet.timeLastPet else {return}
        let timeSinceFed = (currentDate.timeIntervalSince(petLastFed) / 60)
        let timeSincePet = (currentDate.timeIntervalSince(petLastPet) / 100)
        pet.hunger = min(100, pet.hunger + Int64(timeSinceFed))
        pet.happiness = max(0, pet.happiness - Int64(timeSincePet))
        saveToPersistentStore()
    }
    
    func release(pet: Pet) {
        CoreDataStack.managedObjectContext.delete(pet)
        saveToPersistentStore()
    }
    
    func releaseAllPets() {
        let request: NSFetchRequest<NSFetchRequestResult> = Pet.fetchRequest()
        let batchDelete = NSBatchDeleteRequest(fetchRequest: request)
        let moc = CoreDataStack.managedObjectContext
        do {
            try moc.execute(batchDelete)
        } catch {
            print(error.localizedDescription)
        }
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
