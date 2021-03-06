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
        if loginText.text == "" || passwordText.text == ""{
            wrongText.isHidden = false
        } else {
            let login = loginText.text
            let password = passwordText.text
            print("\(login!), \(password!)")
            let credenciales = "\(login!):\(password!)"
            let credB64 = credenciales.data(using: String.Encoding.utf8)!.base64EncodedString()
            print(credB64)
            
            //token
            let cabeceras = ["Authorization": "Basic \(credB64)"]
            guard let cliente = RestClient(service: "",response: self, cabeceras) else {
                return
            }
            cliente.request()
            
            //usuario
            guard let clienteUser = RestClient(service: "usuario/login/\(login!)",response: self, [:]) else {
                return
            }
            clienteUser.request()
        
        }
    }
    
    @IBAction func registerbTN(_ sender: Any) {
        /*if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AccountSettingsController") as? AccountSettingsController
        {
            //present(vc, animated: true, completion: nil)
            show(vc, sender: self)
            vc.registerClicked = true
        }*/
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "registerSegue" {
            let mainVC: AccountSettingsController = segue.destination as! AccountSettingsController
            mainVC.registerClicked = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordText.isSecureTextEntry = true
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.items?[3].isEnabled = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.items?[3].isEnabled = true
    }
    
    func onData(data: Data) {
        print(String(data:data,encoding:String.Encoding.utf8)!)
        do {
            var token = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            var tk = token["token"]
            UserDefaults.standard.set(tk, forKey: "token")
            
            
        } catch let parsingError {
            print("Error porque estoy cogiendo el usuario en lugar del token", parsingError)
        }
        do{
            print("en usuario")
            print(String(data:data,encoding:String.Encoding.utf8)!)
            let decoder = JSONDecoder()
             let usuarios = try decoder.decode(Usuario.self, from:data)
            if usuarios.usuario.count < 1 {
             print("Usuario o clave incorrectos")
             } else {
             //print("\(usuarios.usuario[0])")
             for usuarioRest in usuarios.usuario{
             print("foreach---\(usuarioRest)" )
             user = User(id: Int(usuarioRest.id) ?? 0, login: usuarioRest.login, key: usuarioRest.clave, email: usuarioRest.correo, name: usuarioRest.nombre, lastname: usuarioRest.apellidos, address: usuarioRest.direccion, signedUp: stringToDate(usuarioRest.fecha_alta), active: Bool(usuarioRest.activo) ?? false, admin: Bool(usuarioRest.activo) ?? false, cvv: "", expiration: "", creditCard: "")
             }
             print("\(user?.getName()) usuario ")
             
             
             saveUser(user: user)
             guard let userData = UserDefaults.standard.object(forKey: "userData") as? NSData else {
             print("'shopBag' not found in UserDefaults")
             return
             }
             
             guard let user = NSKeyedUnarchiver.unarchiveObject(with: userData as Data) as? User else {
             print("Could not unarchive from placesData")
             return
             }
             print("Nombre pref --- \(user.getName()) .. \(user.getSignedUp())")
             
             performSegue(withIdentifier: "loginSegue", sender: nil)
             }
        } catch let parsingError {
            print("Error porque estoy cogiendo el token en lugar del user", parsingError)
        }
    }
    
    func onDataError(message: String) {
        print("error LogIn")
    }
    
    public func saveUser(user: User?) {
        if let userToSave = user {
            let preferences = UserDefaults.standard
            let userNS = NSKeyedArchiver.archivedData(withRootObject: userToSave)
            preferences.set(userNS, forKey: "userData")
            preferences.set(userToSave.getId(), forKey: "userId")
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
