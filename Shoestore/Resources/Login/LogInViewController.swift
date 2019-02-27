//
//  LogInViewController.swift
//  Shoestore
//
//  Created by dam on 12/2/19.
//  Copyright © 2019 dam. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController, OnResponse {
    var user:User?
    
    @IBOutlet weak var loginText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var wrongText: UILabel!
    
    @IBAction func loginBtn(_ sender: Any) {
        print("HEY")
        if loginText.text == "" || passwordText.text == ""{
            wrongText.isHidden = false
        } else {
            let login = loginText.text
            let password = passwordText.text
            print("\(login!), \(password!)")
            
            guard let cliente = RestClient(service: "usuario/\(login!)/key/\(password!)",response: self) else {
                return
            }
            cliente.request()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordText.isSecureTextEntry = true
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
                     user = User(id: Int(usuarioRest.id) ?? 0, login: usuarioRest.login, key: usuarioRest.clave, email: usuarioRest.correo, name: usuarioRest.nombre, lastname: usuarioRest.apellidos, address: usuarioRest.direccion, signedUp: stringToDate(usuarioRest.fecha_alta), active: Bool(usuarioRest.activo) ?? false, admin: Bool(usuarioRest.activo) ?? false)
                }
                /*let user = User(id: Int(usuarios.usuario[0].id) ?? 0, login: usuarios.usuario[0].login , key: usuarios.usuario[0].clave , email: usuarios.usuario[0].correo , name: usuarios.usuario[0].nombre , lastname: usuarios.usuario[0].apellidos , address: usuarios.usuario[0].direccion , signedUp: stringToDate(usuarios.usuario[0].fecha_alta), active: Bool(usuarios.usuario[0].activo)!, admin: Bool(usuarios.usuario[0].admin)!)*/
                        
                saveUser(user: user)
                if UserDefaults.standard.object(forKey: "user") == nil {
                    if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserViewController") as? UserViewController
                    {
                        present(vc, animated: true, completion: nil)
                    }
                }
            }
        } catch let parsingError {
            print("Error", parsingError)
        }
    }
    
    func onDataError(message: String) {
        print("error LogIn")
    }
    
    public func saveUser(user: User?) {
        if let userToSave = user {
            let preferences = UserDefaults.standard
            //preferences.set(user, forKey: "user")
            let userNS = NSKeyedArchiver.archivedData(withRootObject: userToSave)
            preferences.set(userNS, forKey: "userData")
            preferences.set(userToSave.getId(), forKey: "userId")
            let didSave = preferences.synchronize()
            if !didSave {
                print("error al guardar usuario")
            }
        }
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
    
}
