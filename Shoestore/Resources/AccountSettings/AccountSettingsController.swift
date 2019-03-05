//
//  AccountSettingsController.swift
//  Shoestore
//
//  Created by dam on 25/2/19.
//  Copyright © 2019 dam. All rights reserved.
//

import Foundation
import UIKit

class AccountSettingsController: UIViewController, UIImagePickerControllerDelegate/*, OnResponse*/{
    
    var usuario:User?
    let preferences = UserDefaults.standard
    var registerClicked = false
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        if registerClicked {
            
        } else {
            loadUsers()
            loadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        nameTf.text = usuario?.getName()
        surnameTf.text = usuario?.getLastname()
        adressTf.text = usuario?.getAddress()
        emailTf.text = usuario?.getEmail()
    }
    
    @IBAction func saveButton(_ sender: Any) {
        usuario?.setName(name: nameTf.text!)
        usuario?.setLastname(lastname: surnameTf.text!)
        usuario?.setAddress(address: adressTf.text!)
        usuario?.setEmail(email: emailTf.text!)
        
        saveUser(user: usuario)
        
        let datosUser:[String : Any] = ["login" : usuario?.getId(), "clave" : usuario?.getKey(), "correo" : usuario?.getEmail(), "direccion" : usuario?.getAddress(), "nombre" : usuario?.getName(), "apellidos" : usuario?.getLastname(), "fecha_alta" : usuario?.getSignedUp(), "activo" : usuario?.active, "admin" : usuario?.admin]
        print("\(datosUser)")
        
        /*guard let cliente = RestClient(service: "usuario/", response: self, "PUT", datosUser) else {
            return
        }
        
        cliente.request()*/
        
        dismiss(animated: true, completion: nil)
    }
    
    public func saveUser(user: User?) {
        if let userToSave = user {
            let preferences = UserDefaults.standard
            //preferences.set(user, forKey: "user")
            let userNS = NSKeyedArchiver.archivedData(withRootObject: userToSave)
            preferences.set(userNS, forKey: "userData")
            preferences.set(userToSave.getId(), forKey: "userId")
        }
    }
    
    /*func onData(data: Data) {
        print("onData")
    }
    
    func onDataError(message: String) {
        print("onError")
    }*/
}
