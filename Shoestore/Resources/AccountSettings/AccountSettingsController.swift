//
//  AccountSettingsController.swift
//  Shoestore
//
//  Created by dam on 25/2/19.
//  Copyright © 2019 dam. All rights reserved.
//

import Foundation
import UIKit

class AccountSettingsController: UIViewController, OnResponse {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
    }
    
    func onData(data: Data) {
        <#code#>
    }
    
    func onDataError(message: String) {
        <#code#>
    }
}
