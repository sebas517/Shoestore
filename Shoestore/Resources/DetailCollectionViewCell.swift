//
//  DetailCollectionViewCell.swift
//  Shoestore
//
//  Created by dam on 20/02/2019.
//  Copyright © 2019 dam. All rights reserved.
//

import UIKit

class DetailCollectionViewCell: UICollectionViewCell {
    
    var brandString: String?
    var modelString: String?
    var priceShoe: String?
    var shoe: Shoe?
    
    @IBOutlet weak var imagen: UIImageView!
    
    @IBOutlet weak var brand: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
    
}
