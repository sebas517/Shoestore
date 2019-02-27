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
    var usuario:User?
    var usuarios:[User] = []
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
        
        /*imagePicker.delegate = (self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate)*/
        usuarios = []
        loadUsers()
        loadData()
    }
    
    func onData(data: Data) {
        print("onData")
    }
    
    func onDataError(message: String) {
        print("onError")
    }
    
    func loadUsers() {
        guard let users = UserDefaults.standard.object(forKey: "userData") as? NSData else {
            print ("user not found in UserDefaults")
            return
        }
        
        guard let usuarios = NSKeyedUnarchiver.unarchiveObject(with: users as Data) as? [User] else{
        print("Could not unarchive from placesData")
        return
        }
    
        if(usuarios.count > 0) {
            self.usuarios = usuarios
        }
    }
    
    func loadData() {
        nameTf.text = usuarios[0].name
        surnameTf.text = usuarios[0].lastname
        adressTf.text = usuarios[0].address
        emailTf.text = usuarios[0].email
    }
}
