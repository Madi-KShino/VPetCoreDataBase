//
//  PetsViewController.swift
//  TamagotchiCoreData
//
//  Created by Madison Kaori Shino on 1/12/20.
//  Copyright © 2020 HaleyJones. All rights reserved.
//

import UIKit

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
    
    func fetchPets() {
        
    }
    
    //MARK: - Navigation
    @IBAction func unwindFromAdoptVC(segue:UIStoryboardSegue) {
        let data = segue.source as? AdoptViewController
        guard let nameEntered = data?.name else { return }
        PetController.sharedInstance.createPet(withName: nameEntered)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}

//TableView Data Source
extension PetsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let pairs = pairs else { return 0 }
        let sectionCount = pairs.count - 1
        if section <= sectionCount {
            return pairs[section].count
        } else { return 0 }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if pairs == nil {
            return ""
        } else {
            return "Pair \(section+1)"
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        let headerLabel = UILabel(frame: CGRect(x: 30, y: 0, width:
            tableView.bounds.size.width, height: tableView.bounds.size.height))
        headerLabel.font = UIFont(name: "Arial Rounded MT Bold", size: 15)
        headerLabel.textColor = #colorLiteral(red: 0.8236967921, green: 0.5886859298, blue: 0.6307470798, alpha: 1)
        headerLabel.text = self.tableView(nameListTableView, titleForHeaderInSection: section)
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        guard let pairs = pairs else { return UITableViewCell() }
        let person = pairs[indexPath.section][indexPath.row]
        cell.textLabel?.text = person.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard var pairs = pairs else { return }
            let person = pairs[indexPath.section][indexPath.row]
            PersonController.shared.delete(person: person) { (success) in
                if success {
                    DispatchQueue.main.async {
                        pairs[indexPath.section].remove(at: indexPath.row)
                        guard let index = self.people.firstIndex(of: person) else { return }
                        self.people.remove(at: index)
                        self.createNewPairings()
                        self.nameListTableView.reloadData()
                        print("success")
                    }
                }
            }
        }
    }
}
