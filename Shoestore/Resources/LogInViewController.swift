//
//  LogInViewController.swift
//  Shoestore
//
//  Created by dam on 12/2/19.
//  Copyright © 2019 dam. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController, OnResponse {
    var user:User!
    
    @IBAction func loginBtn(_ sender: Any) {
        guard let cliente = RestClient(service: "usuario/",response: self) else {
            return
        }
        cliente.request()
    }
    
    @IBAction func btnBack(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func onData(data: Data) {
        do {
            let decoder = JSONDecoder()
            let usuarios = try decoder.decode(Usuario.self, from:data)
            
            if usuarios.usuario.count < 1 {
                print("Usuario o clave incorrectos")
            } else {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
                
                user = User(id: Int(usuarios.usuario[0].id)!, login: usuarios.usuario[0].login, key: usuarios.usuario[0].clave, email: usuarios.usuario[0].correo, name: usuarios.usuario[0].nombre, lastname: usuarios.usuario[0].apellidos, address: usuarios.usuario[0].direccion, signedUp: stringToDate(usuarios.usuario[0].fecha_alta), active: Bool(usuarios.usuario[0].activo)!, admin: Bool(usuarios.usuario[0].admin)!)
                
                saveUser(user: user)
            }
            
//            for userRest in usuarios.usuario {
//                users.append(User(id: Int(userRest.id) ?? 0, login: String(userRest.login), key: String(userRest.clave), email: userRest.correo , name: userRest.nombre, lastname: String(userRest.apellidos), address: userRest.direccion, signedUp: Date(userRest.fecha_alta), active: userRest.activo, admin: userRest.admin))
//            }
            
            /*for shoe in shoes {
             print("\(shoe.getId())...\(shoe.getBrand())...\(shoe.getModel())...\(shoe.getPrice())")
             }*/
            
            
            //tabla.reloadData()
        } catch let parsingError {
            print("Error", parsingError)
        }
    }
    
    func onDataError(message: String) {
        print("error LogIn")
    }
    
    public func saveUser(user: User) {
        let preferences = UserDefaults.standard
        preferences.set(user, forKey: "user")
        let didSave = preferences.synchronize()
        if !didSave {
            
        }
    }

    public func stringToDate(_ strings: String) -> Date {
        
        let formatter = DateFormatter()
        return formatter.date(from: strings)!
    }
    
}
