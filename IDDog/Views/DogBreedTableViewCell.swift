//
//  DogBreedTableViewCell.swift
//  IDDog
//
//  Created by Vladimir Mironiuk on 03.04.2020.
//  Copyright © 2020 Vladimir Mironiuk. All rights reserved.
//

import UIKit
import MBCircularProgressBar

class DogBreedTableViewCell: UITableViewCell {
  
  // MARK: - Properties
  
  @IBOutlet weak var confidenceView: MBCircularProgressBarView!
  @IBOutlet weak var breedNameLabel: UILabel!
}
