//
//  Categoria.swift
//  Shoestore
//
//  Created by dam on 6/2/19.
//  Copyright © 2019 dam. All rights reserved.
//

import Foundation

class Category
{
    var id: Int
    var name: String
    
    init(id: Int, name:String) {
        self.id = id
        self.name = name
    }
    
    func getId() -> Int {
        return self.id
    }
    
    func getName() -> String {
        return self.name
    }
    
    func setName(name:String) {
        self.name = name
    }
    
    func setId(id: Int) {
        self.id = id
    }
}
