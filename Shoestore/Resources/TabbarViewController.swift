//
//  TabbarViewController.swift
//  Shoestore
//
//  Created by dam on 27/2/19.
//  Copyright © 2019 dam. All rights reserved.
//

import UIKit

class TabbarViewController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.items?[3].isEnabled = true
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
