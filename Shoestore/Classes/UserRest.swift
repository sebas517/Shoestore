//
//  UserRest.swift
//  Shoestore
//
//  Created by dam on 18/2/19.
//  Copyright © 2019 dam. All rights reserved.
//

import Foundation

struct UserRest: Codable {
    var id:String
    var login:String
    var clave:String
    var correo:String
    var nombre:String
    var apellidos:String
    var direccion:String
    var fecha_alta:String
    var activo:String
    var admin:String
}

struct Usuario: Codable {
    let usuario: [UserRest]
}
