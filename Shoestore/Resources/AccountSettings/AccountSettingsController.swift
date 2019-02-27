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
        loadUsers()
        loadData()
    }
    
    func onData(data: Data) {
        do {
            let decoder = JSONDecoder()
            let usuarios = try decoder.decode(Usuario.self, from:data)
            
            
            if usuarios.usuario.count < 1 {
                print("Usuario o clave incorrectos")
            } else {
                //print("\(usuarios.usuario[0])")
                for usuarioRest in usuarios.usuario{
                    print("foreach---\(usuarioRest.login)...\(usuarioRest.clave)" )
                    usuario = User(id: Int(usuarioRest.id) ?? 0, login: usuarioRest.login, key: usuarioRest.clave, email: usuarioRest.correo, name: usuarioRest.nombre, lastname: usuarioRest.apellidos, address: usuarioRest.direccion, signedUp: stringToDate(usuarioRest.fecha_alta), active: Bool(usuarioRest.activo) ?? false, admin: Bool(usuarioRest.activo) ?? false)
                }
        
            }
        } catch let parsingError {
            print("Error", parsingError)
        }
    }
    
    func onDataError(message: String) {
        print("onError")
    }
    
    func loadUsers() {
        let userId = UserDefaults.standard.integer(forKey: "userId")
        
        guard let cliente = RestClient(service: "usuario/\(userId)",response: self) else {
            return
        }
        
        print("ID:\(userId)")
        cliente.request()
        
        /*
        guard let usuarios = NSKeyedUnarchiver.unarchiveObject(with: users as Data) as? [User] else{
            print("Could not unarchive from placesData")
            return
        }
    
        if(usuarios.count > 0) {
            self.usuarios = usuarios
        }*/
    }
    
    public func stringToDate(_ strings: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        let date = formatter.date(from:strings)!
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: date)
        let finalDate = calendar.date(from:components)
        return finalDate!
    }
    
    func loadData() {
        nameTf.text = usuario?.name/* ?? "Usuario"*/
        surnameTf.text = usuario?.lastname/* ?? "Clave"*/
        adressTf.text = usuario?.address/* ?? "Direccion"*/
        emailTf.text = usuario?.email/* ?? "E-mail"*/
    }
}
