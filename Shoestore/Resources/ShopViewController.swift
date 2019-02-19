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
        shoes = []
        loadShoes()
        if  shoes.count != 0{
            for shoe in shoes {
                print("preferences: \(shoe.brand)...\(shoe.model)")
            }
        }
        tableView.reloadData()
        navigationItem.leftBarButtonItem = editButtonItem
        if let shoe = shoe {
            saveShoe(shoe: shoe)
            tableView.reloadData()
        }
    }
    
    func saveShoe(shoe: Shoe) {
        shoes.append(shoe)
        for shoe in shoes {
            print("al llegar: \(shoe.brand)...\(shoe.model)")
        }
        let shopBag = NSKeyedArchiver.archivedData(withRootObject: shoes)
        preferences.set(shopBag, forKey: "shopBag")
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
        
        self.shoes = shoes
        tableView.reloadData()
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension ShopViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        print("secciones")
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("tamaño")
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
        
        cell.model.text = shoes[indexPath.row].getModel()
        cell.price.text = "\(String(shoes[indexPath.row].getPrice()))€"
        cell.brand.text = shoes[indexPath.row].getBrand()
        
        print("pintar")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            shoes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            preferences.set(shoes, forKey: "shoes")
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
}
