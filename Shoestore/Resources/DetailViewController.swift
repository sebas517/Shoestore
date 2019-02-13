//
//  DetailViewController.swift
//  Shoestore
//
//  Created by dam on 12/2/19.
//  Copyright © 2019 dam. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var shoe:Shoe?

    @IBAction func btnBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if  let shoe = shoe{
            print("\(shoe.getId())...\(shoe.getBrand())...\(shoe.getModel())...\(shoe.getPrice())")
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
