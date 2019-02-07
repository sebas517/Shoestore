//
//  Categoria.swift
//  ClienteServerRest
//
//  Created by dam on 31/1/19.
//  Copyright © 2019 dam. All rights reserved.
//

import Foundation


struct Categoria: Codable{
    var id:Int
    var nombre: String
}

struct Categorias: Codable{
    let categorias: [Categoria]
}
