//
//  AdoptViewController.swift
//  TamagotchiCoreData
//
//  Created by Madison Kaori Shino on 1/12/20.
//  Copyright © 2020 HaleyJones. All rights reserved.
//

import UIKit

class AdoptViewController: UIViewController {
    
    //Properties
    var name: String?

    //Outlets
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var namePetlabel: UILabel!
    @IBOutlet weak var petImage: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var adoptButton: UIButton!
    @IBOutlet weak var dismissButton: UIButton!
    
    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }

    //Actions
    @IBAction func dismissButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func adoptButtonTapped(_ sender: Any) {
        if nameTextField.text != "" {
            name = nameTextField.text
            performSegue(withIdentifier: "toHomeVC", sender: self)
        }
    }
    
    //Helper Functions
    func setView() {
        popupView.layer.cornerRadius = 25
        popupView.layer.borderColor = #colorLiteral(red: 0.2979488373, green: 0.4786220193, blue: 0.5023182034, alpha: 1)
        popupView.layer.borderWidth = 3
        cancelButton.layer.cornerRadius = cancelButton.frame.height / 2
        adoptButton.layer.cornerRadius = adoptButton.frame.height / 2
        cancelButton.layer.borderWidth = 2
        adoptButton.layer.borderWidth = 2
        cancelButton.layer.borderColor = #colorLiteral(red: 0.2979488373, green: 0.4786220193, blue: 0.5023182034, alpha: 1)
        adoptButton.layer.borderColor = #colorLiteral(red: 0.2979488373, green: 0.4786220193, blue: 0.5023182034, alpha: 1)
    }
}

//Dismiss Keyboard
extension AdoptViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
