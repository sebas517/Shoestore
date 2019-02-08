//
//  ShoeRest.swift
//  Shoestore
//
//  Created by dam on 8/2/19.
//  Copyright © 2019 dam. All rights reserved.
//

import Foundation

struct ZapatoRest: Codable{
    var id:String
    var idcategoria: String
    var iddestinatario:String
    var marca:String
    var modelo:String
    var precio:String
    var color:String
    var material_cubierta:String
    var material_forro:String
    var material_suela:String
    var numero_desde:String
    var numero_hasta:String
    var descripcion:String
    var disponibilidad:String
    var imagen: String
}

struct Zapato:Codable {
    let zapato: [ZapatoRest]
}
