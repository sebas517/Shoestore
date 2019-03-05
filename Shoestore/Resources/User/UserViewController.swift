//
//  UserViewController.swift
//  Shoestore
//
//  Created by dam on 5/2/19.
//  Copyright © 2019 dam. All rights reserved.
//

import UIKit

class UserViewController: UIViewController, OnResponse {
    var user:User!
    
    @IBOutlet var usernameText: UITextField!
    @IBAction func logOut(_ sender: Any) {
        UserDefaults.standard.set(nil, forKey: "userData")
        UserDefaults.standard.set(nil, forKey: "userKey")
        
        
    
        //checkUser()
        //dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkUser()
        // Do any additional setup after loading the view.
    }
    
    func onData(data: Data) {
        do {
            let decoder = JSONDecoder()
            let usuarios = try decoder.decode(Usuario.self, from:data)
            print("\(usuarios)")
            
            if usuarios.usuario.count < 1 {
                print("Usuario o clave incorrectos")
            } else {
                user = User(id: Int(usuarios.usuario[0].id)!, login: usuarios.usuario[0].login, key: usuarios.usuario[0].clave, email: usuarios.usuario[0].correo, name: usuarios.usuario[0].nombre, lastname: usuarios.usuario[0].apellidos, address: usuarios.usuario[0].direccion, signedUp: stringToDate(usuarios.usuario[0].fecha_alta), active: Bool(usuarios.usuario[0].activo)!, admin: Bool(usuarios.usuario[0].admin)!, cvv: "", expiration: "", creditCard: "")
            }
        } catch let parsingError {
            print("Error", parsingError)
        }
    }
    
    func onDataError(message: String) {
        print("error AccountSettings")
    }
    
    public func checkUser() {
        let usuario = UserDefaults.standard
        print("checkuser")
        if usuario.object(forKey: "userData") == nil {
                //present(vc, animated: true, completion: nil)
                performSegue(withIdentifier: "toLogin", sender: self)
        } else {
            guard let cliente = RestClient(service: "usuario/\(String(describing: usuario.string(forKey: "userId")))", response: self) else {
                return
            }
            cliente.request()
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
     
     cambios...
     
    }
    */

}
