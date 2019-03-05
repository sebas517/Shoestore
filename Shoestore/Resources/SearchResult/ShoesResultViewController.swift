//
//  ShoesResultViewController.swift
//  Shoestore
//
//  Created by dam on 11/02/2019.
//  Copyright © 2019 dam. All rights reserved.
//

import UIKit

class ShoesResultViewController: UIViewController, OnResponse, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var shoeCollection: UICollectionView!
    var shoes: [Shoe] = []
    var shoesFound: [Shoe] = []
    var categoria: Int? = -1
    var destinatario: Int?
    var search: String?
    var categories:[Category] = []
    var shoe: Shoe!
    var shoeSelected: Shoe!
    
    @IBOutlet weak var collectionShoesFound: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        llamarCliente()
        // llamarClienteCategorias()
        print("Recibido \(categoria)  \(destinatario) \(search)")
        
        /*  if (search != "" && categoria != -1){
         guard let cliente = RestClient(service: "zapato/\(categoria)/destinatario/\(destinatario)/busqueda/\(search)",response: self)
         else {
         return
         }
         cliente.request()
         }else if(categoria != -1){
         guard let cliente = RestClient(service: "zapato/destinatario/\(destinatario)/busqueda/\(search)",response: self) else {
         return
         }
         cliente.request()
         
         }*/
        // Do any additional setup after loading the view.
    }
    
    func onData(data: Data) {
        do {
            let decoder = JSONDecoder()
            let zapatos = try decoder.decode(Zapato.self, from:data)
            for zapatoRest in zapatos.zapato {
                shoes.append(Shoe(id: Int(zapatoRest.id) ?? 0, category: Int(zapatoRest.idcategoria) ?? 0, idDestinatario: Int(zapatoRest.iddestinatario) ?? 0, brand: zapatoRest.marca , model: zapatoRest.modelo, price: Float(zapatoRest.precio) ?? 0.0, color: zapatoRest.color, coverMaterial: zapatoRest.material_cubierta, insideMaterial: zapatoRest.material_forro, soleMaterial: zapatoRest.material_suela, numberFrom: Int(zapatoRest.numero_desde) ?? 0, numberTo: Int(zapatoRest.numero_hasta) ?? 0, desc: zapatoRest.descripcion, stock: Int(zapatoRest.disponibilidad) ?? 0, image: zapatoRest.imagen))
            }
            print ("entra en el ONDATA")
            if (categoria != nil){
                for shoe in shoes {
                    if (shoe.category == categoria && shoe.idDestinatario == destinatario){
                        if (shoe.model == search || shoe.brand == search){
                            shoesFound.append(shoe)
                            print ("entra en el primer if")
                        }
                    }
                }
            }else {
                for shoe in shoes {
                    if (shoe.idDestinatario == destinatario){
                        var comprobar = shoe.brand
                        comprobar += " "
                        comprobar += shoe.model
                      
                        print ("buscnado")
                        print ("\(comprobar.uppercased())")
                        if (shoe.model.uppercased() == search?.uppercased() || shoe.brand.uppercased() == search?.uppercased() ){
                            if (!shoesFound.contains(shoe)){
                            shoesFound.append(shoe)
                            }
                            print("entra, son iguales")
                        }
                        else if (comprobar.uppercased() == search?.uppercased() ){
                            print("BSUUSQUEDA IGUAL A  ")
                            print(comprobar)
                             shoesFound.append(shoe)
                        }
                    }
                }
            }
            collectionShoesFound.reloadData()
            //--Si no se encuentran zapatos en la busqueda, lanza un alert y carga todos los zapatos de la BD
            if (search != nil && search != ""){
            if (shoesFound.count <= 0){
                let alerta = UIAlertController(title: "No se ha encontrado la búsqueda",
                                               message: "Por favor, revise los datos introducidos",
                                               preferredStyle: UIAlertController.Style.alert)
                let accion = UIAlertAction(title: "Cerrar",
                                           style: UIAlertAction.Style.default) { _ in
                                            alerta.dismiss(animated: true, completion: nil) }
                alerta.addAction(accion)
                self.present(alerta, animated: true, completion: nil)
                loadAllShoes()
            }
            }else{
                let alerta = UIAlertController(title: "No se han introducido datos",
                                               message: "Por favor, introduzca datos para realizar la búsqueda",
                                               preferredStyle: UIAlertController.Style.alert)
                let accion = UIAlertAction(title: "Cerrar",
                                           style: UIAlertAction.Style.default) { _ in
                                            alerta.dismiss(animated: true, completion: nil) }
                alerta.addAction(accion)
                self.present(alerta, animated: true, completion: nil)
                loadAllShoes()
            }
            
            
            //      tabla.reloadData()
            
        } catch let parsingError {
            print("Error", parsingError)
        }
    }
    
    func onDataError(message: String) {
        print("Error")
    }
    
    
    func loadAllShoes(){
        var shoeInsert: [Shoe] = []
        if (shoes.count > 0){
            for shoeAux in shoes{
                shoesFound.append(shoeAux)
            }
            collectionShoesFound.reloadData()
        }
    }
    
    @IBOutlet weak var btnFilter: UIButton!
    let searchBrand: String! = nil
    //  var search: String! = ""
    //var destinatario: Int! = -1
    // var categoria: Int! = -1
    
    
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int ) -> Int{
        return shoesFound.count
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.shoeSelected = shoesFound[indexPath.row]
        print("pulsado zapato \(shoeSelected.brand)")
        //  mostrarZapato()
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celda: SearchResultViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchResultCell", for: indexPath) as! SearchResultViewCell
        let tamanioPantalla = UIScreen.main.bounds
        let anchoCelda = (tamanioPantalla.width/5.0)
        //var imagen = relatedShoes[indexPath.row].image
        let shoeAux: Shoe = shoesFound[indexPath.row]
        celda.Brand.text = "\(shoeAux.brand.uppercased())"
        celda.model.text = shoeAux.model.uppercased()
        celda.price.text = String("\(shoeAux.getPrice()) €")
        
        let urlImagen =  shoeAux.getImage()
        if  let url = URL(string: urlImagen) {
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
        return celda
    }
    
    
    
    
    override func unwind(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
        print("SEGUE")
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func filter(_ sender: Any) {
        
        print("Filtrar")
    }
    
    
    //----SEGE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let DetailViewController = segue.destination as? DetailViewController else {
            fatalError("Unexpected destination: \(segue.destination)")
        }
        
        guard let selectedShoeCell = sender as? SearchResultViewCell else {
            fatalError("Unexpected sender: \(sender)")
        }
        
        
        guard let indexPath = collectionShoesFound.indexPath(for: selectedShoeCell) else {
            fatalError("The selected cell is not being displayed by the table")
        }
        
        let selectedShoe = shoesFound[indexPath.row]
        DetailViewController.shoe = selectedShoe
        
       
        
    }
    
    
    
}



