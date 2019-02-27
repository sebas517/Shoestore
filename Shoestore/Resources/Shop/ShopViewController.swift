//
//  ShopViewController.swift
//  Shoestore
//
//  Created by dam on 5/2/19.
//  Copyright © 2019 dam. All rights reserved.
//

import UIKit

class ShopViewController: UIViewController {
    
    var shoe:Shoe?
    var shoes:[Shoe] = []
    let preferences = UserDefaults.standard
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.setEditing(true, animated: true)
        loadShoes()
        
        if let shoe = shoe {
            saveShoe(shoe: shoe)
        }
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
    
    
    @IBAction func reset_shop(_ sender: Any) {
        deleteShopBag()
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
        
        cell.brand.text = shoes[indexPath.row].getModel()
        cell.price.text = "\(String(shoes[indexPath.row].getPrice()))€"
        cell.model.text = shoes[indexPath.row].getBrand()
        return cell
    }
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     print("estoy pulsando la fila \(indexPath.row)")
     }*/
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        print("estoy pulsando la fila \(indexPath.row)")
        if editingStyle == .delete {
            // Delete the row from the data source
            shoes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            updateShoes()
        }
    }
}
