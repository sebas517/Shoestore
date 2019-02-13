//
//  HomeTableViewController.swift
//  Shoestore
//
//  Created by dam on 8/2/19.
//  Copyright © 2019 dam. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController, OnResponse {
    
    @IBOutlet var tabla: UITableView!
    var shoes: [Shoe] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        guard let cliente = RestClient(service: "zapato/",response: self) else {
            return
        }
        cliente.request()
    }
    
    func onData(data: Data) {
        do {
            let decoder = JSONDecoder()
            let zapatos = try decoder.decode(Zapato.self, from:data)
            
            for zapatoRest in zapatos.zapato {
                shoes.append(Shoe(id: Int(zapatoRest.id) ?? 0, category: Int(zapatoRest.idcategoria) ?? 0, idDestinatario: Int(zapatoRest.iddestinatario) ?? 0, brand: zapatoRest.marca , model: zapatoRest.modelo, price: Float(zapatoRest.precio) ?? 0.0, color: zapatoRest.color, coverMaterial: zapatoRest.material_cubierta, insideMaterial: zapatoRest.material_forro, soleMaterial: zapatoRest.material_suela, numberFrom: Int(zapatoRest.numero_desde) ?? 0, numberTo: Int(zapatoRest.numero_hasta) ?? 0, description: zapatoRest.descripcion, stock: Int(zapatoRest.disponibilidad) ?? 0, image: zapatoRest.imagen))
            }
            
            /*for shoe in shoes {
                print("\(shoe.getId())...\(shoe.getBrand())...\(shoe.getModel())...\(shoe.getPrice())")
            }*/
            
            
            tabla.reloadData()
        } catch let parsingError {
            print("Error", parsingError)
        }
    }
    
    func onDataError(message: String) {
        print("error")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return shoes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Celda", for: indexPath) as! HomeCellTableViewCell
        let urlImagen = shoes[indexPath.row].getImage()
        if let url = URL(string: urlImagen) {
            let cola = DispatchQueue(label: "bajar.imagen", qos: .default, attributes: .concurrent)
            
            cola.async {
                if let data = try? Data(contentsOf: url), let imagen = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.imagen_zapato.image = imagen
                        cell.imagen_zapato.contentMode = UIView.ContentMode.scaleAspectFit
                    }
                }
            }
        }
        
        //cell.imagen_zapato.image = shoes[indexPath.row].getImage()
        cell.modelo.text = shoes[indexPath.row].getModel()
        cell.precio.text = "\(String(shoes[indexPath.row].getPrice()))€"
        cell.marca.text = shoes[indexPath.row].getBrand()
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let DetailViewController = segue.destination as? DetailViewController else {
            fatalError("Unexpected destination: \(segue.destination)")
        }
        guard let selectedShoeCell = sender as? HomeCellTableViewCell else {
            fatalError("Unexpected sender: \(sender)")
        }
        
        guard let indexPath = tableView.indexPath(for: selectedShoeCell) else {
            fatalError("The selected cell is not being displayed by the table")
        }
        
        let selectedShoe = shoes[indexPath.row]
        DetailViewController.shoe = selectedShoe
        
    }
    

}
