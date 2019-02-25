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
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var relatedShoes: [Shoe] = []
    var shoe:Shoe?
    var shoes: [Shoe] = []
    var categories:[Category] = []
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return relatedShoes.count
    }
    
    //  func collectionView(_ collectionView: UICollectionView, //numberOfItemsInSection section: Int, IndexPath: IndexPath) -> Int {
    // return 1}
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let celda: DetailCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "shoeCell", for: indexPath) as! DetailCollectionViewCell
        let tamanioPantalla = UIScreen.main.bounds
        let anchoCelda = (tamanioPantalla.width/5.0)
        //var imagen = relatedShoes[indexPath.row].image
        
        let shoeAux: Shoe = relatedShoes[indexPath.row]
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
        
       // celda.brand.text = relatedShoes[indexPath.row].getBrand()
        
       // celda.price.text = "\(String(relatedShoes[indexPath.row].getPrice()))€"
        
        //  celda.brand.text =  relatedShoes[indexPath.row].getBrand()
        
        //  celda.price.text = "\(relatedShoes[indexPath.row].price)"
        
        // celda.brand.text = "\(relatedShoes[indexPath.row].brand)"
        
        
        return celda
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         self.shoe = relatedShoes[indexPath.row]
        mostrarZapato()   
    }
    
    func actualizarZapatosRelacinados(shoeRelacionated:Shoe?){
        relatedShoes = []
        if  let shoe = shoeRelacionated{
            for zapatoRest in shoes {
                if  (shoe.category  == Int(zapatoRest.category) ?? 0 && shoe.idDestinatario == Int(zapatoRest.idDestinatario) ?? 0
                    && shoe.model != zapatoRest.model){
                    //  if(shoe?.model != zapatoRest.modelo){
                    relatedShoes.append(Shoe(id: Int(zapatoRest.id) ?? 0, category: shoe.category ?? 0, idDestinatario: shoe.idDestinatario ?? 0, brand: zapatoRest.brand , model: zapatoRest.model, price: zapatoRest.price, color: zapatoRest.color, coverMaterial: zapatoRest.coverMaterial, insideMaterial: zapatoRest.insideMaterial, soleMaterial: zapatoRest.soleMaterial, numberFrom:zapatoRest.numberFrom, numberTo: zapatoRest.numberTo, desc: zapatoRest.desc, stock: zapatoRest.stock , image: zapatoRest.image))

                }
            }
            collectionRelatedShoes.reloadData()
        }
    }
    
    func llamarCliente(){
        guard let cliente = RestClient(service: "zapato/",response: self) else {
            return
        }
        cliente.request()
    }
    
    
    func llamarClienteCategorias(){
        guard let cliente = RestClient(service: "categoria/",response: self) else {
            return
        }
        cliente.request()
    }
    
    func mostrarZapato(){
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
            for categoria in categories{
                if (categoria.id == shoe.category){
                    category.text = categoria.getName()
                }
            }
            //category.text = "botines, hombre"
            price.text = "\(shoe.price)"
            coverMaterial.text = "\(shoe.coverMaterial)"
            insideMaterial.text = "\(shoe.insideMaterial)"
            soleMaterial.text = "\(shoe.soleMaterial)"
            numbers.text = "\(shoe.numberFrom)...\(shoe.numberTo)"
            stock.text = "\(shoe.stock)"
            color.text = "\(shoe.color)"
            if(shoe.idDestinatario == 1){
                destinatary.text = "Niña"
            }
            else if(shoe.idDestinatario == 2){
                destinatary.text = "Niño"
            }
            else if(shoe.idDestinatario == 3){
                destinatary.text = "Hombre"
            }
            else if(shoe.idDestinatario == 4){
                destinatary.text = "Mujer"
            }
        actualizarZapatosRelacinados(shoeRelacionated: shoe)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.center = self.view.center
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        
        llamarCliente()
        llamarClienteCategorias()

        //Asignacion imagen
        
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
                shoes.append(Shoe(id: Int(zapatoRest.id) ?? 0, category: Int(zapatoRest.idcategoria) ?? 0, idDestinatario: Int(zapatoRest.iddestinatario) ?? 0, brand: zapatoRest.marca , model: zapatoRest.modelo, price: Float(zapatoRest.precio) ?? 0.0, color: zapatoRest.color, coverMaterial: zapatoRest.material_cubierta, insideMaterial: zapatoRest.material_forro, soleMaterial: zapatoRest.material_suela, numberFrom: Int(zapatoRest.numero_desde) ?? 0, numberTo: Int(zapatoRest.numero_hasta) ?? 0, desc: zapatoRest.descripcion, stock: Int(zapatoRest.disponibilidad) ?? 0, image: zapatoRest.imagen))
            }
            
            
            /*for zapatoRest in zapatos.zapato {
                if  (shoe?.category  == Int(zapatoRest.idcategoria) ?? 0 && shoe?.idDestinatario == Int(zapatoRest.iddestinatario) ?? 0
                    && shoe?.model != zapatoRest.modelo){
                  //  if(shoe?.model != zapatoRest.modelo){
                    relatedShoes.append(Shoe(id: Int(zapatoRest.id) ?? 0, category: shoe?.category ?? 0, idDestinatario: shoe?.idDestinatario ?? 0, brand: zapatoRest.marca , model: zapatoRest.modelo, price: Float(zapatoRest.precio) ?? 0.0, color: zapatoRest.color, coverMaterial: zapatoRest.material_cubierta, insideMaterial: zapatoRest.material_forro, soleMaterial: zapatoRest.material_suela, numberFrom: Int(zapatoRest.numero_desde) ?? 0, numberTo: Int(zapatoRest.numero_hasta) ?? 0, desc: zapatoRest.descripcion, stock: Int(zapatoRest.disponibilidad) ?? 0, image: zapatoRest.imagen))
                    
                    
               // }
                }
            }*/
            
            
            
        } catch {
        }
        do {
            
            let decoder = JSONDecoder()
            let categorias = try decoder.decode(Categorias.self, from:data)
            for categoryRest in categorias.categorias {
                categories.append(Category(id: categoryRest.id, name: categoryRest.nombre))
            }
            mostrarZapato()
            activityIndicator.stopAnimating()
        } catch {
        }
    }
    
    func onDataError(message: String) {
        print("error")
    }
    
    
    
}



