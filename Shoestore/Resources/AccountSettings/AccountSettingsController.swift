//
//  AccountSettingsController.swift
//  Shoestore
//
//  Created by dam on 25/2/19.
//  Copyright © 2019 dam. All rights reserved.
//

import Foundation
import UIKit

class AccountSettingsController: UIViewController, UIImagePickerControllerDelegate{
    var usuario:User?
    let preferences = UserDefaults.standard
    
    @IBOutlet weak var nameTf: UITextField!
    @IBOutlet weak var surnameTf: UITextField!
    @IBOutlet weak var adressTf: UITextField!
    @IBOutlet weak var emailTf: UITextField!
    
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
        
        loadUsers()
        loadData()
    }
    
    func loadUsers() {
        guard let userData = UserDefaults.standard.object(forKey: "userData") as? NSData else {
            print("'shopBag' not found in UserDefaults")
            return
        }
        
        guard let user = NSKeyedUnarchiver.unarchiveObject(with: userData as Data) as? User else {
            print("Could not unarchive from placesData")
            return
        }
        
        usuario = user
        
    }
    
    func loadData() {
        nameTf.text = usuario?.getName()/* ?? "Usuario"*/
        surnameTf.text = usuario?.getLastname()/* ?? "Clave"*/
        adressTf.text = usuario?.getAddress()/* ?? "Direccion"*/
        emailTf.text = usuario?.getEmail()/* ?? "E-mail"*/
    }
}
