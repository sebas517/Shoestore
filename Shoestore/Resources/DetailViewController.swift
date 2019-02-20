//
//  DetailViewController.swift
//  Shoestore
//
//  Created by dam on 12/2/19.
//  Copyright © 2019 dam. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
     var shoes: [Shoe] = []
    
    @IBOutlet weak var color: UILabel!
    
    @IBOutlet weak var collectionRelatedShoes: UICollectionView!
    var shoe:Shoe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Asignacion imagen
        if  let shoe = shoe{
            let urlImagen = shoe.getImage()
            if let url = URL(string: urlImagen) {
                let cola = DispatchQueue(label: "bajar.imagen", qos: .default, attributes: .concurrent)
                
                cola.async {
                    if let data = try? Data(contentsOf: url), let imagen = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.imgzap.image = imagen
                             self.imgzap.contentMode = .scaleAspectFit
                            
                        }
                    }
                }
            }
            //Asignacion resto de campos
            brand.text = "\(shoe.brand)"
            
            model.text = "\(shoe.model)"
            category.text = "botines, hombre"
            price.text = "\(shoe.price)"
            coverMaterial.text = "\(shoe.coverMaterial)"
            insideMaterial.text = "\(shoe.insideMaterial)"
            soleMaterial.text = "\(shoe.soleMaterial)"
            numbers.text = "\(shoe.numberFrom)...\(shoe.numberTo)"
            stock.text = "\(shoe.stock)"
            color.text = "\(shoe.color)"
            
            if(shoe.idDestinatario == 1){
                destinatary.text = "Mujer"
            }
            else if(shoe.idDestinatario == 2){
                destinatary.text = "Hombre"
            }
            else if(shoe.idDestinatario == 3){
                destinatary.text = "Niño"
            }
            else if(shoe.idDestinatario == 4){
                destinatary.text = "Niña"
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let ShopViewController = segue.destination as? ShopViewController else {
            fatalError("Unexpected destination: \(segue.destination)")
        }
        /*guard let selectedShoeCell = sender as? HomeCellTableViewCell else {
         fatalError("Unexpected sender: \(sender)")
         }
         guard let indexPath = tableView.indexPath(for: selectedShoeCell) else {
         fatalError("The selected cell is not bng displayed by the table")
         }*/  
        let selectedShoe = shoe
        ShopViewController.shoe = selectedShoe
    }
    
    
    
    
    //Funciones para zapatos relacionados
    
    
    
    func onData(data: Data) {
        do {
            let decoder = JSONDecoder()
            let zapatos = try decoder.decode(Zapato.self, from:data)
            
            for zapatoRest in zapatos.zapato {
                shoes.append(Shoe(id: Int(zapatoRest.id) ?? 0, category: shoe?.category ?? 0, idDestinatario: shoe?.idDestinatario ?? 0, brand: "\(shoe?.brand)" , model: zapatoRest.modelo, price: Float(zapatoRest.precio) ?? 0.0, color: zapatoRest.color, coverMaterial: zapatoRest.material_cubierta, insideMaterial: zapatoRest.material_forro, soleMaterial: zapatoRest.material_suela, numberFrom: Int(zapatoRest.numero_desde) ?? 0, numberTo: Int(zapatoRest.numero_hasta) ?? 0, desc: zapatoRest.descripcion, stock: Int(zapatoRest.disponibilidad) ?? 0, image: zapatoRest.imagen))
            }
            
            /*for shoe in shoes {
             print("\(shoe.getId())...\(shoe.getBrand())...\(shoe.getModel())...\(shoe.getPrice())")
             }*/
            
            
            collectionRelatedShoes.reloadData()
            
        } catch let parsingError {
            print("Error", parsingError)
        }
    }
    
    func onDataError(message: String) {
        print("error")
    }
    
    
}

