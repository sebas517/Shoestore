//
//  Shoe.swift
//  Shoestore
//
//  Created by dam on 6/2/19.
//  Copyright © 2019 dam. All rights reserved.
//

import Foundation

class Shoe: NSObject, NSCoding{
    
    
    var id: Int
    var category: Int
    var idDestinatario: Int
    var brand: String
    var model: String
    var price: Float
    var color: String
    var coverMaterial: String
    var insideMaterial: String
    var soleMaterial: String
    var numberFrom: Int
    var numberTo: Int
    var desc: String
    var stock: Int
    var image: String
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(category, forKey: "category")
        aCoder.encode(idDestinatario, forKey: "idDestinatario")
        aCoder.encode(brand, forKey: "brand")
        aCoder.encode(model, forKey: "model")
        aCoder.encode(price, forKey: "price")
        aCoder.encode(color, forKey: "color")
        aCoder.encode(coverMaterial, forKey: "coverMaterial")
        aCoder.encode(insideMaterial, forKey: "insideMaterial")
        aCoder.encode(soleMaterial, forKey: "soleMaterial")
        aCoder.encode(numberTo, forKey: "numberTo")
        aCoder.encode(numberFrom, forKey: "numberFrom")
        aCoder.encode(desc, forKey: "description")
        aCoder.encode(stock, forKey: "stock")
        aCoder.encode(image, forKey: "image")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeInteger(forKey: "id")
        self.category = aDecoder.decodeInteger(forKey: "category")
        self.idDestinatario = aDecoder.decodeInteger(forKey: "idDestinatario")
        self.brand = aDecoder.decodeObject(forKey: "brand") as? String ?? ""
        self.model = aDecoder.decodeObject(forKey: "model") as? String ?? ""
        self.price = aDecoder.decodeFloat(forKey: "price")
        self.color = aDecoder.decodeObject(forKey: "color") as? String ?? ""
        self.coverMaterial = aDecoder.decodeObject(forKey: "coverMaterial") as? String ?? ""
        self.insideMaterial =  aDecoder.decodeObject(forKey: "insideMaterial") as? String ?? ""
        self.soleMaterial = aDecoder.decodeObject(forKey: "soleMaterial") as? String ?? ""
        self.numberFrom = aDecoder.decodeInteger(forKey: "numberFrom")
        self.numberTo = aDecoder.decodeInteger(forKey: "numberTo")
        self.desc = aDecoder.decodeObject(forKey: "description") as? String ?? ""
        self.stock = aDecoder.decodeInteger(forKey: "stoc")
        self.image = aDecoder.decodeObject(forKey: "image") as? String ?? ""
    }
    
    init(id: Int, category: Int, idDestinatario:Int, brand: String, model: String, price: Float, color: String, coverMaterial: String, insideMaterial: String, soleMaterial: String, numberFrom: Int, numberTo: Int, desc: String, stock: Int, image: String) {
        
        self.id = id
        self.category = category
        self.idDestinatario = idDestinatario
        self.brand = brand
        self.model = model
        self.price = price
        self.color = color
        self.coverMaterial = coverMaterial
        self.insideMaterial = insideMaterial
        self.soleMaterial = soleMaterial
        self.numberFrom = numberFrom
        self.numberTo = numberTo
        self.desc = desc
        self.stock = stock
        self.image = image
    }
    
    func getId() -> Int {
        return self.id
    }
    
    func getCategory() -> Int {
        return self.category
    }
    
    func getIdDestinatario()->Int{
        return self.idDestinatario
    }
    
    func getBrand() -> String {
        return self.brand
    }

    func getModel() -> String {
        return self.model
    }
    
    func getPrice() -> Float {
        return self.price
    }
    
    func getColor() -> String {
        return self.color
    }
    
    func getCoverMaterial() -> String {
        return self.coverMaterial
    }
    
    func getInsideMaterial() -> String {
        return self.insideMaterial
    }
    
    func getSoleMaterial() -> String {
        return self.soleMaterial
    }
    
    func getNumberFrom() -> Int {
        return self.numberFrom
    }
    
    func getNumberTo() -> Int {
        return self.numberTo
    }
    
    func getDescription() -> String {
        return self.desc
    }
    
    func getStock() -> Int{
        return self.stock
    }
    
    func getImage()->String{
        return self.image
    }
    
    func setCategory(category: Int) {
        self.category = category
    }
    
    func setIdDestinatario (idDestinatario: Int) {
        self.idDestinatario = idDestinatario
    }

    func setBrand(brand: String) {
        self.brand = brand
    }
    
    func setModel(model: String)  {
        self.model = model
    }
    
    func setPrice(price: Float) {
        self.price = price
    }
    
    func setColor(color: String) {
        self.color = color
    }

    func setCoverMaterial(coverMaterial: String) {
        self.coverMaterial = coverMaterial
    }
    
    func setInsideMaterial(insideMaterial: String) {
        self.insideMaterial = insideMaterial
    }
    
    func setSoleMaterial(soleMaterial: String) {
        self.soleMaterial = soleMaterial
    }
    
    func setNumberFrom(numberfrom: Int) {
        self.numberFrom = numberfrom
    }
    
    func setNumberTo(numberTo: Int) {
        self.numberTo = numberTo
    }
    
    func setDescription(desc: String) {
        self.desc = desc
    }
    
    func setStock(stock: Int)  {
        self.stock = stock
    }
    
    func setImage(image: String) {
        self.image = image
    }

}
