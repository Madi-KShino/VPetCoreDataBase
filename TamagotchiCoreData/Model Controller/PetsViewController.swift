//
//  PetsViewController.swift
//  TamagotchiCoreData
//
//  Created by Madison Kaori Shino on 1/12/20.
//  Copyright © 2020 HaleyJones. All rights reserved.
//

import UIKit
import CoreData

class PetsViewController: UIViewController {

    //Properties
    var pets: [Pet] = []
    
    //Outlets
    @IBOutlet weak var petListTableView: UITableView!
    @IBOutlet weak var adoptNewPetButton: UIBarButtonItem!
    
    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setMainView()
        setNavBarView()
        setDelegates()
    }
    
    //Helper Functions
    func setMainView() {
        petListTableView.layer.cornerRadius = 25
    }
    
    func setNavBarView() {
        adoptNewPetButton.title = "Adopt"
        let label = UILabel()
        label.text = "My Pets"
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.textAlignment = .left
        label.sizeToFit()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 35)
        navigationItem.titleView = label
    }
    
    func setDelegates() {
        petListTableView.dataSource = self
        petListTableView.delegate = self
    }
    
    //MARK: - Navigation
    @IBAction func unwindFromAdoptVC(segue:UIStoryboardSegue) {
        let data = segue.source as? AdoptViewController
        guard let nameEntered = data?.name else { return }
        PetController.sharedInstance.createPet(withName: nameEntered)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}

//MARK: - Table View Data Source
extension PetsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        PetController.sharedInstance.fetchedResultController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "petCell", for: indexPath) as? PetTableViewCell else { return UITableViewCell() }
        let pet = PetController.sharedInstance.fetchedResultController.object(at: indexPath)
        cell.update(withPet: pet)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let petToRelease = PetController.sharedInstance.fetchedResultController.object(at: indexPath)
            PetController.sharedInstance.release(pet: petToRelease)
        }
    }
}

//MARK: - NSFetchedResultsControllerDelegate
extension PetsViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        petListTableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            guard let indexPath = indexPath else {return}
            petListTableView.deleteRows(at: [indexPath], with: .automatic)
        case .insert:
            guard let newIndexPath = newIndexPath else {return}
            petListTableView.insertRows(at: [newIndexPath], with: .automatic)
        case .move:
            guard let oldIndexPath = indexPath, let newIndexPath = newIndexPath else {return}
            petListTableView.moveRow(at: oldIndexPath, to: newIndexPath)
        case .update:
            guard let indexPath = indexPath else {return}
            petListTableView.reloadRows(at: [indexPath], with: .automatic)
        @unknown default:
            fatalError()
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch (type) {
        case NSFetchedResultsChangeType.insert:
            self.petListTableView?.insertSections(NSIndexSet.init(index: sectionIndex) as IndexSet, with: .fade)
        case NSFetchedResultsChangeType.delete:
            self.petListTableView.deleteSections(NSIndexSet.init(index: sectionIndex) as IndexSet, with: .fade)
        default:
            return
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        petListTableView.endUpdates()
    }
}
