//
//  User.swift
//  Shoestore
//
//  Created by dam on 6/2/19.
//  Copyright © 2019 dam. All rights reserved.
//

import Foundation

class User: NSObject, NSCoding{
    
    
    var id: Int
    var login: String
    var key: String
    var email: String
    var name: String
    var lastname: String
    var address: String
    var signedUp: Date
    var active: Bool
    var admin: Bool
    var cvv: String
    var expiration: String
    var creditCard: String
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(login, forKey: "login")
        aCoder.encode(key, forKey: "key")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(lastname, forKey: "lastname")
        aCoder.encode(address, forKey: "address")
        aCoder.encode(signedUp, forKey: "signedUp")
        aCoder.encode(active, forKey: "active")
        aCoder.encode(admin, forKey: "admin")
        aCoder.encode(cvv, forKey: "cvv")
        aCoder.encode(expiration, forKey: "expiration")
        aCoder.encode(creditCard, forKey: "creditCard")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeInteger(forKey: "id")
        self.login = aDecoder.decodeObject(forKey: "login") as? String ?? ""
        self.key = aDecoder.decodeObject(forKey: "key") as? String ?? ""
        self.email = aDecoder.decodeObject(forKey: "email") as? String ?? ""
        self.name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        self.lastname = aDecoder.decodeObject(forKey: "lastname") as? String ?? ""
        self.address = aDecoder.decodeObject(forKey: "address") as? String ?? ""
        self.signedUp = aDecoder.decodeObject(forKey: "signedUp") as! Date
        self.active = aDecoder.decodeBool(forKey: "active")
        self.admin = aDecoder.decodeBool(forKey: "admin")
        self.cvv = aDecoder.decodeBool(forKey: "cvv")
        self.expiration = aDecoder.decodeBool(forKey: "expiration")
        self.creditCard = aDecoder.decodeBool(forKey: "creditCard")
        
    }
    
    init(id: Int, login: String, key: String, email: String, name: String, lastname: String, address: String, signedUp: Date, active: Bool, admin: Bool, cvv: String, expiration: String, creditCard: String) {
        self.id = id
        self.login = login
        self.key = key
        self.email = email
        self.name = name
        self.lastname = lastname
        self.address = address
        self.signedUp = signedUp
        self.active = active
        self.admin = admin
        self.cvv = cvv
        self.expiration = expiration
        self.creditCard = creditCard
    }
    
    func getId() -> Int {
        return self.id
    }
    
    func getLogin() -> String {
        return self.login
    }
    
    func getKey() -> String{
        return self.key
    }
    
    func getEmail() -> String {
        return self.email
    }
    
    func getName() -> String {
        return self.name
    }
    
    func getLastname() -> String{
        return self.lastname
    }
    
    func getAddress() -> String{
        return self.address
    }
    
    func getSignedUp() -> Date {
        return self.signedUp
    }
    
    func isActive() -> Bool {
        return self.active
    }
    
    func isAdmin() -> Bool {
        return self.admin
    }
    
    func getCvv() ->String{
        return self.cvv
    }
    
    func getExpiration() -> String {
        return self.expiration
    }
    
    func getCreditCard() -> String {
        return self.creditCard
    }
    
    func setId(id:Int) {
        self.id = id
    }
    
    func setLogin(login: String) {
        self.login = login
    }
    
    func setKey(key: String) {
        self.key = key
    }
    
    func setEmail(email: String) {
        self.email = email
    }
    
    func setName(name: String) {
        self.name = name
    }
    
    func setLastname(lastname: String) {
        self.lastname  = lastname
        
    }
    
    func setAddress(address: String) {
        self.address = address
    }
    
    func setSignedUp(signedUp: Date) {
        self.signedUp = signedUp
    }
    
    func setActive(active: Bool) {
        self.active = active
    }
    
    func setAdmin(admin: Bool) {
        self.admin = admin
    }
    
    
}
