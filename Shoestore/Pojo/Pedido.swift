//
//  Pedido.swift
//  Shoestore
//
//  Created by dam on 6/2/19.
//  Copyright © 2019 dam. All rights reserved.
//

import Foundation

class Pedido {
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
