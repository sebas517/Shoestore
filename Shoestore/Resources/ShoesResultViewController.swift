//
//  ShoesResultViewController.swift
//  Shoestore
//
//  Created by dam on 11/02/2019.
//  Copyright © 2019 dam. All rights reserved.
//

import UIKit

class ShoesResultViewController: UIViewController, UICollectionViewDataSource,  UICollectionViewDelegate, OnResponse{

    
    @IBOutlet weak var shoeCollection: UICollectionView!
    var shoes: [Shoe] = []
    
    func onData(data: Data) {
        do {
            let decoder = JSONDecoder()
            let zapatos = try decoder.decode(Zapato.self, from:data)
            
            for zapatoRest in zapatos.zapato {
                shoes.append(Shoe(id: Int(zapatoRest.id) ?? 0, category: Int(zapatoRest.idcategoria) ?? 0, brand: zapatoRest.marca , model: zapatoRest.modelo, price: Float(zapatoRest.precio) ?? 0.0, color: zapatoRest.color, coverMaterial: zapatoRest.material_cubierta, insideMaterial: zapatoRest.material_forro, soleMaterial: zapatoRest.material_suela, numberFrom: Int(zapatoRest.numero_desde) ?? 0, numberTo: Int(zapatoRest.numero_hasta) ?? 0, description: zapatoRest.descripcion, stock: Int(zapatoRest.disponibilidad) ?? 0, image: zapatoRest.imagen))
            }
            
            for shoe in shoes {
                print("SALIDA \(shoe.getId())...\(shoe.getBrand())...\(shoe.getModel())...\(shoe.getPrice())")
            }
            
            
            //      tabla.reloadData()
            
        } catch let parsingError {
            print("Error", parsingError)
        }
    }
    
    func onDataError(message: String) {
        print("Error")
    }
    
    
    @IBOutlet weak var btnFilter: UIButton!
    let searchBrand: String! = nil
    var search: String! = ""
    var destinatario: Int! = -1
    var categoria: Int! = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (search != "" && categoria != -1){
            guard let cliente = RestClient(service: "zapato/\(categoria)/destinatario/\(destinatario)/busqueda/\(search)",response: self) else {
                return
            }
            cliente.request()
        }else if(categoria != -1){
            guard let cliente = RestClient(service: "zapato/destinatario/\(destinatario)/busqueda/\(search)",response: self) else {
                return
            }
            cliente.request()
            
        }
        // Do any additional setup after loading the view.
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int ) -> Int{
        return 1
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellShoe", for: indexPath) as! SearchResultViewCell
        
        
        cell.search = search
        return cell
        
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
    
}

