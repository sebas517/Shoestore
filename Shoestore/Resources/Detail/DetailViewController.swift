//
//  DetailViewController.swift
//  Shoestore
//
//  Created by dam on 12/2/19.
//  Copyright © 2019 dam. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, OnResponse, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource, UIPickerViewDataSource, UIPickerViewDelegate{
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var selectNumber: UIPickerView!
    
    @IBOutlet weak var destinatary: UILabel!
    
    @IBOutlet weak var colorShoe: UILabel!
    @IBOutlet weak var brand: UILabel!
    @IBOutlet weak var imgzap: UIImageView!
    @IBOutlet weak var model: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var stock: UILabel!
    @IBOutlet weak var insideMaterial: UILabel!
    @IBOutlet weak var coverMaterial: UILabel!
    @IBOutlet weak var soleMaterial: UILabel!
    @IBOutlet weak var numbers: UILabel!
    @IBOutlet weak var color: UILabel!
    @IBOutlet weak var collectionRelatedShoes: UICollectionView!
    var numbersArray: [String] = [String]()
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var relatedShoes: [Shoe] = []
    var shoe:Shoe?
    var shoesShopBag:[Shoe] = []
    var shoes: [Shoe] = []
    var categories:[Category] = []
    let preferences = UserDefaults.standard
    
    var numeroSeleccionado: Int!
    
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
            model.text = "\(shoe.model) - \(shoe.color)"
            var categoriaShoe = ""
            var destinatario = ""
            for categoria in categories{
                if (categoria.id == shoe.category){
                    categoriaShoe = categoria.getName()
                }
            }
            if(shoe.idDestinatario == 1){
                destinatario = "Niña"
            }
            else if(shoe.idDestinatario == 2){
                destinatario="Niño"
            }
            else if(shoe.idDestinatario == 3){
                destinatario="Hombre"
            }
            else if(shoe.idDestinatario == 4){
                destinatario="Mujer"
            }
            category.text = categoriaShoe
            destinatary.text = destinatario
            colorShoe.text = "\(shoe.color)"
            price.text = "\(shoe.price)"
            coverMaterial.text = "\(shoe.coverMaterial)"
            insideMaterial.text = "\(shoe.insideMaterial)"
            soleMaterial.text = "\(shoe.soleMaterial)"
          
            loadSelectorNumero()
            
            //  numbers.text = "\(shoe.numberFrom)...\(shoe.numberTo)"
           // stock.text = "\(shoe.stock)"
            if (shoe.stock > 0){
                  color.text="En stock"
            }else{
                 color.text="Fuera de strock"
                
            }
      //      color.text = "\(shoe.color)"
            
            actualizarZapatosRelacinados(shoeRelacionated: shoe)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //-------Selector de numeros para el zapato
       loadSelectorNumero()
    
        
        // selectNumber.selectRow(0, inComponent: 1, animated: true)
        
        activityIndicator.center = self.view.center
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        loadShoes()
        
        llamarCliente()
        llamarClienteCategorias()
        
        //Asignacion imagen
        
    }
    
    
    func loadSelectorNumero(){
    
    selectNumber.delegate = self as? UIPickerViewDelegate
    selectNumber.dataSource = self as? UIPickerViewDataSource
         numbersArray = []
    var cont: Int = (shoe?.numberFrom)!
    let numMax: Int = (shoe?.numberTo)!
    if (cont > 0){
    while(cont < numMax+1){
    numbersArray.append(String(cont))
    cont = cont + 1
    }
    
    }
    
    
    }
    //-------------_CESTA_---------------
    
    @IBAction func addBag(_ sender: Any) {
        if let shoe = shoe {
            saveShoe(shoe: shoe)
        }
        
    }
    
    func loadShoes() {
        shoesShopBag = []
        guard let shopBag = UserDefaults.standard.object(forKey: "shopBag") as? NSData else {
            print("'shopBag' not found in UserDefaults")
            return
        }
        
        guard let shoes = NSKeyedUnarchiver.unarchiveObject(with: shopBag as Data) as? [Shoe] else {
            print("Could not unarchive from placesData")
            return
        }
        if (shoes.count > 0) {
            self.shoesShopBag = shoes
        }
        
    }
    
    func saveShoe(shoe: Shoe) {
        shoesShopBag.append(shoe)
        let shopBag = NSKeyedArchiver.archivedData(withRootObject: shoesShopBag)
        preferences.set(shopBag, forKey: "shopBag")
    }
    
    //-------------_CESTA_---------------
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (shoe!.stock <= 0){
            let alerta = UIAlertController(title: "No hay stock",
                                           message: "Lo sentimos, actualmente no hay stock de este modelo",
                                           preferredStyle: UIAlertController.Style.alert)
            let accion = UIAlertAction(title: "Cerrar",
                                       style: UIAlertAction.Style.default) { _ in
                                        alerta.dismiss(animated: true, completion: nil) }
            alerta.addAction(accion)
            self.present(alerta, animated: true, completion: nil)
            
        }else{
        super.prepare(for: segue, sender: sender)
        }
        /*guard let ShopViewController = segue.destination as? ShopViewController else {
         fatalError("Unexpected destination: \(segue.destination)")
         }*/
        /*guard let selectedShoeCell = sender as? HomeCellTableViewCell else {
         fatalError("Unexpected sender: \(sender)")
         }
         guard let indexPath = tableView.indexPath(for: selectedShoeCell) else {
         fatalError("The selected cell is not bng displayed by the table")
         }*/
        /*let selectedShoe = shoe
         ShopViewController.shoe = selectedShoe*/
    }
    
    //Funciones para zapatos relacionados
    func onData(data: Data) {
        do {
            let decoder = JSONDecoder()
            let zapatos = try decoder.decode(Zapato.self, from:data)
            for zapatoRest in zapatos.zapato {
                shoes.append(Shoe(id: Int(zapatoRest.id) ?? 0, category: Int(zapatoRest.idcategoria) ?? 0, idDestinatario: Int(zapatoRest.iddestinatario) ?? 0, brand: zapatoRest.marca , model: zapatoRest.modelo, price: Float(zapatoRest.precio) ?? 0.0, color: zapatoRest.color, coverMaterial: zapatoRest.material_cubierta, insideMaterial: zapatoRest.material_forro, soleMaterial: zapatoRest.material_suela, numberFrom: Int(zapatoRest.numero_desde) ?? 0, numberTo: Int(zapatoRest.numero_hasta) ?? 0, desc: zapatoRest.descripcion, stock: Int(zapatoRest.disponibilidad) ?? 0, image: zapatoRest.imagen))
            }
            
            
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
    
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        guard let label = view as? UILabel else {
            preconditionFailure ("Expected a Label")
        }
        
        label.font = UIFont(name: "Arial-BoldMT", size: 10)
        
      //  selectNumber.text = pickerData[row]
        return label
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        print("entra en ppicker")
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        print("entra en ppicker")
        return numbersArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //   numbers.text = numbersArray[row]
        var seleccionado: String = numbersArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        print("entra en ppicker")
        return numbersArray[row]
        
    }
    
    
    
    
}


