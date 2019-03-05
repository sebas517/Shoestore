//
//  Pedido.swift
//  Shoestore
//
//  Created by dam on 6/2/19.
//  Copyright © 2019 dam. All rights reserved.
//

import Foundation

class Pedido: NSObject, NSCoding{
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(user, forKey: "user")
        aCoder.encode(shoes, forKey: "shoes")
        aCoder.encode(date, forKey: "date")
        aCoder.encode(creditCard, forKey: "creditCard")
        aCoder.encode(expiration, forKey: "expiration")
        aCoder.encode(cvv, forKey: "cvv")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeInteger(forKey: "id")
        self.user = (aDecoder.decodeObject(forKey: "login") as? User ?? nil)!
        self.shoes = (aDecoder.decodeObject(forKey: "shoes") as? [Shoe] ?? nil)!
        self.date = aDecoder.decodeObject(forKey: "date") as! Date
        self.creditCard = aDecoder.decodeObject(forKey: "creditCard") as? String ?? ""
        self.cvv = aDecoder.decodeObject(forKey: "cvv") as? String ?? ""
        self.expiration = aDecoder.decodeObject(forKey: "expiration") as? String ?? ""
    }
    
    var id: Int
    var user: User
    var shoes: [Shoe]
    var date: Date
    var creditCard: String
    var expiration: String
    var cvv: String
    
    init(id: Int, user: User, shoes: [Shoe], date:Date, creditCard: String, expiration: String, cvv: String) {
        self.id = id
        self.user = user
        self.shoes = shoes
        self.date = date
        self.creditCard = creditCard
        self.expiration = expiration
        self.cvv = cvv
    }
    
    func getId() -> Int {
        return self.id
    }
    
    func getUser() -> User {
        return self.user
    }
    
    func getShoes() -> [Shoe] {
        return self.shoes
    }
    
    func getDate() -> Date {
        return self.date
    }
    
    func getCreditCard() -> String {
        return self.creditCard
    }
    
    func getExpiration() -> String {
        return self.expiration
    }
    
    func getCvv() -> String {
        return self.cvv
    }
    
    func setUser(user: User) {
        self.user = user
    }
    
    func setShoes(shoes: [Shoe]) {
        self.shoes = shoes
    }
    
    func setDate(date: Date) {
        self.date = date
    }
    
    func setCreditCard(creditCard: String) {
        self.creditCard = creditCard
    }
    
    func setExpiration(expiration: String) {
        self.expiration = expiration
    }
    
    func setCvv(cvv: String) {
        self.cvv = cvv
    }
    
    
    
}
