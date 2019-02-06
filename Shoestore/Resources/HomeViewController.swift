//
//  HomeViewController.swift
//  Shoestore
//
//  Created by dam on 5/2/19.
//  Copyright © 2019 dam. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, OnResponse {
    
    private var categories: [Category] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let cliente = RestClient(service: "categoria",response: self) else {
            return
        }
        cliente.request()
        // Do any additional setup after loading the view.
    }
    func onData(data: Data) {
        print(data)
        do {
            let decoder = JSONDecoder()
            let categorias = try decoder.decode(Categorias.self, from:data)
            
            for categoryRest in categorias.categorias {
                categories.append(Category(id: categoryRest.id, name: categoryRest.nombre))
            }

            for category in categories {
                print("\(category.getId())....\(category.getName())")
            }
        } catch let parsingError {
            print("Error", parsingError)
        }
    }
    
    func onDataError(message: String) {
        print(message)
    }

}
