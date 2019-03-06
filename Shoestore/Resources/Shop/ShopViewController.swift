//
//  ShopViewController.swift
//  Shoestore
//
//  Created by dam on 5/2/19.
//  Copyright © 2019 dam. All rights reserved.
//

import UIKit

class ShopViewController: UIViewController, OnResponse{
   
    @IBOutlet weak var pedidosRealizados: UIButton!
    
    @IBOutlet weak var total: UILabel!
    
    @IBOutlet weak var shopBag: UITabBarItem!

    @IBOutlet weak var loginPay: UIButton!
    
    @IBAction func loginPay(_ sender: Any) {
        if  isLogged{
            savePedido()
        } else {
            performSegue(withIdentifier: "loginSegue", sender: nil)
        }
    }
    
    @IBAction func showPedidos(_ sender: Any) {
        if c == 0{
            pedidosRealizados.setTitle("Cesta", for: UIControl.State.normal)
            shoes = pedidos
            tableView.reloadData()
            c = 1
        }else{
            pedidosRealizados.setTitle("Pedidos", for: UIControl.State.normal)
            loadShoes()
            if shoes.count == 0 {
                self.total.text = "0.0€"
            }
            tableView.reloadData()
            c = 0
        }
        
    }
    
    public func checkButton(){
        if UserDefaults.standard.object(forKey: "userData")  == nil{
            loginPay.setTitle("Login", for: UIControl.State.normal)
            isLogged = false
        }else{
            isLogged = true
            loginPay.setTitle("Pagar", for: UIControl.State.normal)
        }
    }
    
    var c = 0
    var havePedido = false
    var isLogged = false
    var pedido: [String: Any] = [:]
    var shoe:Shoe?
    var pedidos:[Shoe] = []
    var shoes:[Shoe] = []
    let preferences = UserDefaults.standard
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.setEditing(true, animated: true)
        pedidosRealizados.isHidden = true
        
        self.total.text = "0.0€"
        checkButton()
        loadShoes()
        checkPedidos()
        if  pedidos.count > 0 {
            pedidosRealizados.isHidden = false
        }
        if let shoe = shoe {
            saveShoe(shoe: shoe)
        }
    }
    
    public func checkPedidos(){
        print("checkeamosPedidos")
        guard let pedidosData = UserDefaults.standard.object(forKey: "pedido") as? NSData else {
            print("'shopBag' not found in UserDefaults")
            return
        }
        
        guard let pedidos = NSKeyedUnarchiver.unarchiveObject(with: pedidosData as Data) as? [Shoe] else {
            print("Could not unarchive from placesData")
            return
        }
        for shoe in pedidos{
            
            print("\(shoe.brand)")
        }
        if (pedidos.count > 0) {
            self.pedidos = pedidos
        }
    }
    
    public func savePedido(){

        /*let shopBag = NSKeyedArchiver.archivedData(withRootObject: shoes)
        preferences.set(shopBag, forKey: "pedido")
        
        pedidosRealizados.isHidden = false
        
        deleteShopBag()*/
        guard let userData = UserDefaults.standard.object(forKey: "userData") as? NSData else {
            print("'shopBag' not found in UserDefaults")
            return
        }
        
        guard let user = NSKeyedUnarchiver.unarchiveObject(with: userData as Data) as? User else {
            print("Could not unarchive from placesData")
            return
        }
      
        
        pedido = ["id": 0,
                  "idusuario" : user.getId(),
                  "fecha" : "10-9-21",
                  "numtarjeta": user.getCreditCard(),
                  "validez": user.getExpiration(),
                  "cvv": user.getCvv()]
        print("14")
        print(pedido)
        
        
        guard let token = UserDefaults.standard.object(forKey: "token") as? String else {
            print("'shopBag' not found in UserDefaults")
            return
        }
        
        print(token)
        
        guard let cliente = RestClient(service: "", response: self, ["Authorization": "Bearer \(token)"], "POST", pedido) else {
            print("error al grabar pedio")
            return
        }
        cliente.request()
    }
    
    func onData(data: Data) {
        print("respuesta")
        print(String(data:data,encoding:String.Encoding.utf8)!)
        //let encoder = JSONEncoder()
        
        
    }
    
    func onDataError(message: String) {
        print("error al grabar datos en BBDD")
    }
    
    public func setBadgeValue(value: String){
        shopBag.badgeValue = value
    }
    
    func saveShoe(shoe: Shoe) {
        shoes.append(shoe)
        let shopBag = NSKeyedArchiver.archivedData(withRootObject: shoes)
        preferences.set(shopBag, forKey: "shopBag")
        tableView.reloadData()
    }
    func updateShoes(){
        let shopBag = NSKeyedArchiver.archivedData(withRootObject: shoes)
        preferences.set(shopBag, forKey: "shopBag")
    }
    func deleteShopBag(){
        shoes = []
        let shopBag = NSKeyedArchiver.archivedData(withRootObject: shoes)
        preferences.set(shopBag, forKey: "shopBag")
        tableView.reloadData()
    }
    func loadShoes() {
        shoes = []
        guard let shopBag = UserDefaults.standard.object(forKey: "shopBag") as? NSData else {
            print("'shopBag' not found in UserDefaults")
            return
        }
        
        guard let shoes = NSKeyedUnarchiver.unarchiveObject(with: shopBag as Data) as? [Shoe] else {
            print("Could not unarchive from placesData")
            return
        }
        if (shoes.count > 0) {
            self.shoes = shoes
            tableView.reloadData()
        }
    }
}


extension ShopViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellShop", for: indexPath) as! ShopCellTableViewCell
        let urlImagen = shoes[indexPath.row].getImage()
        if let url = URL(string: urlImagen) {
            let cola = DispatchQueue(label: "bajar.imagen", qos: .default, attributes: .concurrent)
            
            cola.async {
                if let data = try? Data(contentsOf: url), let imagen = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.imgShoe.image = imagen
                        cell.imgShoe.contentMode = UIView.ContentMode.scaleAspectFit
                    }
                }
            }
        }
        var total:Float = 0
        for shoe in shoes {
            total += shoe.getPrice()
        }
        
        self.total.text = "\(total)€"
       
        
        cell.brand.text = shoes[indexPath.row].getModel()
        cell.price.text = "\(String(shoes[indexPath.row].getPrice()))€"
        cell.model.text = shoes[indexPath.row].getBrand()
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            shoes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            if  shoes.count > 0 {
                self.tabBarController?.tabBar.items?[2].badgeValue = "\(shoes.count)"
            }else{
                self.tabBarController?.tabBar.items?[2].badgeValue = nil
            }
            var total:Float = 0
            for shoe in shoes {
                total += shoe.getPrice()
            }
            
            self.total.text = "\(total)€"
            updateShoes()
        }
    }
    
    
    
}

