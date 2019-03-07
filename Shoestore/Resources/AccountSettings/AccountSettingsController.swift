//
//  AccountSettingsController.swift
//  Shoestore
//
//  Created by dam on 25/2/19.
//  Copyright © 2019 dam. All rights reserved.
//

import Foundation
import UIKit

class AccountSettingsController: UIViewController, UIImagePickerControllerDelegate, OnResponse{
    func onData(data: Data) {
        print("respuesta usuar")
    }
    
    func onDataError(message: String) {
        print("error")
    }
    
    
    var usuario:User?
    let preferences = UserDefaults.standard
    var registerClicked = false
    
    @IBOutlet weak var nameTf: UITextField!
    @IBOutlet weak var surnameTf: UITextField!
    @IBOutlet weak var adressTf: UITextField!
    @IBOutlet weak var emailTf: UITextField!
    @IBOutlet weak var creditCard: UITextField!
    @IBOutlet weak var cvv: UITextField!
    @IBOutlet weak var expirationDate: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var passwordTf: UITextField!
    
    let imagePicker = UIImagePickerController()
    
    @IBAction func cancelar(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
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
            if  UserDefaults.standard.object(forKey: "userData") == nil{
                self.tabBarController?.tabBar.items?[3].isEnabled = false
            }
        } else {
            passwordTf.isHidden = true
            loadUsers()
            loadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.items?[3].isEnabled = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTf.isSecureTextEntry = true
        
        checkFields()
    }
    
    func checkFields() {
        saveButton.isEnabled = true
        if nameTf.text != "" && surnameTf.text != "" && adressTf.text != "" && emailTf.text != "" && creditCard.text != "" && cvv.text != "" && expirationDate.text != "" {
            saveButton.isEnabled = true
        }
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
        usuario?.setLogin(login: nameTf.text!)
        usuario?.setKey(key: nameTf.text!)
        usuario?.setLastname(lastname: surnameTf.text!)
        usuario?.setAddress(address: adressTf.text!)
        usuario?.setEmail(email: emailTf.text!)
        usuario?.setCreditCard(creditCard: creditCard.text!)
        usuario?.setCvv(cvv: cvv.text!)
        usuario?.setExpiration(expiration: expirationDate.text!)
        
        saveUser(user: usuario)
        
        let datosUser:[String : Any] = ["id" : usuario?.getId(), "login" : usuario?.getLogin(), "clave" : usuario?.getKey(), "correo" : usuario?.getEmail(), "direccion" : usuario?.getAddress(), "nombre" : usuario?.getName(), "apellidos" : usuario?.getLastname(), "fecha_alta" : usuario?.getSignedUp(), "activo" : usuario?.active, "admin" : usuario?.admin]
        print("\(datosUser)")
        
        if  UserDefaults.standard.object(forKey: "userData") != nil{
            guard let token = UserDefaults.standard.object(forKey: "token") as? String else {
                print("'shopBag' not found in UserDefaults")
                return
            }
            guard let cliente = RestClient(service: "usuario/", response: self, ["Authorization":"Bearer \(token)"] ,"PUT", datosUser) else {
                return
            }
            
            cliente.request()
        }else{
            guard let cliente = RestClient(service: "usuario/", response: self, [:] ,"POST", datosUser) else {
                return
            }
            
            cliente.request()
        }
        
        /**/
        
        let alerta = UIAlertController(title: "Cambios en el Usuario",
                                       message: "Usuario modificado",
                                       preferredStyle: UIAlertController.Style.alert)
        let accion = UIAlertAction(title: "Aceptar",
                                   style: UIAlertAction.Style.default) { _ in
                                    /*alerta.dismiss(animated: true, completion: nil)*/ }
        alerta.addAction(accion)
        self.present(alerta, animated: true, completion: nil)
        
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
