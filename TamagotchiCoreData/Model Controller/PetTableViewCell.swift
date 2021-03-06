//
//  PetTableViewCell.swift
//  TamagotchiCoreData
//
//  Created by Madison Kaori Shino on 1/12/20.
//  Copyright © 2020 HaleyJones. All rights reserved.
//

import UIKit

class PetTableViewCell: UITableViewCell {

    //Properties
    
    //Outlets
    @IBOutlet weak var petPicImageVIew: UIImageView!
    @IBOutlet weak var petNameLabel: UILabel!
    
    //Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //Helper Functions
    func update(withPet pet: Pet) {
        petNameLabel.text = pet.name
    }

}
