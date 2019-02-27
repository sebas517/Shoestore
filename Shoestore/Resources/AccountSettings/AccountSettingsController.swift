//
//  AccountSettingsController.swift
//  Shoestore
//
//  Created by dam on 25/2/19.
//  Copyright © 2019 dam. All rights reserved.
//

import Foundation
import UIKit

class AccountSettingsController: UIViewController, UIImagePickerControllerDelegate, OnResponse {
    
    let imagePicker = UIImagePickerController()
    
    
    @IBAction func imageTap(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if info[UIImagePickerController.InfoKey.originalImage] != nil {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
    }
    
    func onData(data: Data) {
    }
    
    func onDataError(message: String) {
    }
}
