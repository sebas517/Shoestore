//
//  User.swift
//  Shoestore
//
//  Created by dam on 6/2/19.
//  Copyright © 2019 dam. All rights reserved.
//

import Foundation

class User{
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
    
    init(id: Int, login: String, key: String, email: String, name: String, lastname: String, address: String, signedUp: Date, active: Bool, admin: Bool) {
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
