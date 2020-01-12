//
//  PetsViewController.swift
//  TamagotchiCoreData
//
//  Created by Madison Kaori Shino on 1/12/20.
//  Copyright © 2020 HaleyJones. All rights reserved.
//

import UIKit

class PetsViewController: UIViewController {

    //Outlets
    @IBOutlet weak var petListTableView: UITableView!
    @IBOutlet weak var adoptNewPetButton: UIBarButtonItem!
    
    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setMainView()
        setNavBarView()
        
    }
    
    //Actions
    @IBAction func adoptButtonTapped(_ sender: Any) {
        
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
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}
