//
//  ShopCellTableViewCell.swift
//  Shoestore
//
//  Created by dam on 19/2/19.
//  Copyright © 2019 dam. All rights reserved.
//

import UIKit

class ShopCellTableViewCell: UITableViewCell {
    @IBOutlet weak var imgShoe: UIImageView!
    @IBOutlet weak var model: UILabel!
    @IBOutlet weak var brand: UILabel!
    @IBOutlet weak var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
