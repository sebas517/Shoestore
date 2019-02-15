//
//  DetailViewController.swift
//  Shoestore
//
//  Created by dam on 12/2/19.
//  Copyright © 2019 dam. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var brand: UILabel!
    @IBOutlet weak var imgzap: UIImageView!
    @IBOutlet weak var model: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var stock: UILabel!
    @IBOutlet weak var insideMaterial: UILabel!
    @IBOutlet weak var coverMaterial: UILabel!
    
    @IBOutlet weak var soleMaterial: UILabel!
    @IBOutlet weak var number: UILabel!
    
    /*var price: Float
     var color: String
     var coverMaterial: String
     var insideMaterial: String
     var soleMaterial: String
     var numberFrom: Int
     var numberTo: Int
     var description: String
     var stock: Int
     var image: String
     */
    
    @IBOutlet weak var btnShop: UIButton!
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
                        }
                    }
                }
            }
            //Asignacion resto de campos
            brand.text = "\(shoe.brand)"
            
            model.text = "\(shoe.model)"
            category.text = "botines, hombre"
            price.text = "\(shoe.price)"
            
            //   stock.text = "\(shoe.stock)"
            
            coverMaterial.text = "\(shoe.coverMaterial)"
            
            insideMaterial.text = "\(shoe.insideMaterial)"
            
            soleMaterial.text = "\(shoe.soleMaterial)"
            number.text = "\(shoe.numberFrom)...\(shoe.numberTo)"
            //descrption.text = "\(shoe.description)"
            
            /*   if(shoe.idDestinatario == 1){
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
             */
            
            //descrption.text = "\(shoe.description)"
            
            
            
            print("\(shoe.getId())...\(shoe.getBrand())...\(shoe.getModel())...\(shoe.getPrice())")
            
            
            
            // Do any additional setup after loading the view.
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
    
    @IBAction func shop(_ sender: Any) {
        
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
        //ShopViewController.shoe = selectedShoe
    }
    
    
    
}
