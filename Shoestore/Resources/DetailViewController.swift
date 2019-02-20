//
//  DetailViewController.swift
//  Shoestore
//
//  Created by dam on 12/2/19.
//  Copyright © 2019 dam. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, OnResponse, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var brand: UILabel!
    @IBOutlet weak var imgzap: UIImageView!
    @IBOutlet weak var model: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var stock: UILabel!
    @IBOutlet weak var insideMaterial: UILabel!
    @IBOutlet weak var coverMaterial: UILabel!
    @IBOutlet weak var soleMaterial: UILabel!
    @IBOutlet weak var destinatary: UILabel!
    @IBOutlet weak var numbers: UILabel!
    @IBOutlet weak var color: UILabel!
    @IBOutlet weak var collectionRelatedShoes: UICollectionView!
    
    var relatedShoes: [Shoe] = []
    var shoe:Shoe?
    var shoes: [Shoe] = []
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return relatedShoes.count
    }
    
    //  func collectionView(_ collectionView: UICollectionView, //numberOfItemsInSection section: Int, IndexPath: IndexPath) -> Int {
    // return 1}
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("entra antes de creare la celda")
        let celda: DetailCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "shoeCell", for: indexPath) as! DetailCollectionViewCell
        let tamanioPantalla = UIScreen.main.bounds
        let anchoCelda = (tamanioPantalla.width/5.0)
        //var imagen = relatedShoes[indexPath.row].image
        var shoeAux: Shoe = relatedShoes[indexPath.row]
        celda.shoe = shoeAux
        let urlImagen =  celda.shoe?.getImage()
        
        if  let url = URL(string: urlImagen!) {
            let cola = DispatchQueue(label: "bajar.imagen", qos: .default, attributes: .concurrent)
            cola.async {
                if let data = try? Data(contentsOf: url), let imagen = UIImage(data: data) {
                    DispatchQueue.main.async {
                        celda.imagen.image = imagen
                        celda.imagen.contentMode = UIView.ContentMode.scaleAspectFit
                        
                        
                    }
                }
            }
        }
        
        celda.brand.text = relatedShoes[indexPath.row].getBrand()
        celda.price.text = "\(String(relatedShoes[indexPath.row].getPrice()))€"
        
        
        
        
        //  celda.brand.text =  relatedShoes[indexPath.row].getBrand()
        
        //  celda.price.text = "\(relatedShoes[indexPath.row].price)"
        
        // celda.brand.text = "\(relatedShoes[indexPath.row].brand)"
        
        
        return celda
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let cliente = RestClient(service: "zapato/",response: self) else {
            return
        }
        cliente.request()
        
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
            print("Id destinarario zapato escogido: \(shoe.getIdDestinatario())")
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
                print("Entra en bucle zapatorest")
                if (relatedShoes.count < 3){
                    relatedShoes.append(Shoe(id: Int(zapatoRest.id) ?? 0, category: shoe?.category ?? 0, idDestinatario: shoe?.idDestinatario ?? 0, brand: "\(shoe?.brand)" , model: zapatoRest.modelo, price: Float(zapatoRest.precio) ?? 0.0, color: zapatoRest.color, coverMaterial: zapatoRest.material_cubierta, insideMaterial: zapatoRest.material_forro, soleMaterial: zapatoRest.material_suela, numberFrom: Int(zapatoRest.numero_desde) ?? 0, numberTo: Int(zapatoRest.numero_hasta) ?? 0, desc: zapatoRest.descripcion, stock: Int(zapatoRest.disponibilidad) ?? 0, image: zapatoRest.imagen))
                }
            }
            
            for shoe in relatedShoes {
                print("RELACIONADA \(shoe.getId())...\(shoe.getBrand())...\(shoe.getModel())...\(shoe.getIdDestinatario())")
                
            }
            collectionRelatedShoes.reloadData()
            
        } catch let parsingError {
            print("Error", parsingError)
        }
    }
    
    func onDataError(message: String) {
        print("error")
    }
    
    
}



