//
//  Shoe.swift
//  Shoestore
//
//  Created by dam on 6/2/19.
//  Copyright © 2019 dam. All rights reserved.
//

import Foundation

class Shoe{
    var id: Int
    var category: Category
    var brand: String
    var model: String
    var price: Float
    var color: String
    var coverMaterial: String
    var insideMaterial: String
    var soleMaterial: String
    var numberFrom: Int
    var numberTo: Int
    var description: String
    var stock: Int
    
    init(id: Int, category: Category, brand: String, model: String, price: Float, color: String, coverMaterial: String, insideMaterial: String, soleMaterial: String, numberFrom: Int, numberTo: Int, description: String, stock: Int) {
        
        self.id = id
        self.category = category
        self.brand = brand
        self.model = model
        self.price = price
        self.color = color
        self.coverMaterial = coverMaterial
        self.insideMaterial = insideMaterial
        self.soleMaterial = soleMaterial
        self.numberFrom = numberFrom
        self.numberTo = numberTo
        self.description = description
        self.stock = stock
    }
    
    func getId() -> Int {
        return self.id
    }
    
    func getCategory() -> Category {
        return self.category
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
        return self.description
    }
    
    func getStock() -> Int{
        return self.stock
    }
    
    func setCategory(category: Category) {
        self.category = category
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
    
    func setDescription(description: String) {
        self.description = description
    }
    
    func setStock(stock: Int)  {
        self.stock = stock
    }

}
