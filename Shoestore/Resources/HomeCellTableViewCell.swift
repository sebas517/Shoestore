//
//  HomeCellTableViewCell.swift
//  Shoestore
//
//  Created by dam on 8/2/19.
//  Copyright © 2019 dam. All rights reserved.
//

import UIKit

class HomeCellTableViewCell: UITableViewCell {

    @IBOutlet weak var imagen_zapato: UIImageView!
    @IBOutlet weak var modelo: UILabel!
    @IBOutlet weak var marca: UILabel!
    @IBOutlet weak var precio: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
