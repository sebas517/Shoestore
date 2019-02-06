//
//  RestClient.swift
//  ClienteServerRest
//
//  Created by dam on 31/1/19.
//  Copyright © 2019 dam. All rights reserved.
//

import Foundation

class RestClient {
    
    let urlApi: String = "https://doctrine-sebas-517.c9users.io/apislim/"
    let respuesta: OnResponse
    var urlPeticion: URLRequest
    
    init?(service: String, response: OnResponse,
          _ method: String = "GET", _ data : [String:Any] = [:]) {
        guard let url = URL(string: self.urlApi + service) else {
            return nil
        }
        self.respuesta = response
        self.urlPeticion = URLRequest(url: url)
        self.urlPeticion.httpMethod = method
        if method != "GET" && data.count > 0 {
            guard let json = Util.dictToJson(data: data) else {
                return nil
            }
            self.urlPeticion.addValue("application/json",forHTTPHeaderField: "Content-Type")
            self.urlPeticion.addValue("application/json",forHTTPHeaderField: "Accept")
            self.urlPeticion.httpBody = json
        }
    }
    func request() {
        let sesion = URLSession(configuration: URLSessionConfiguration.default)
        let task = sesion.dataTask(with: self.urlPeticion,completionHandler: self.callBack)
        task.resume()
    }
    
    private func callBack(_ data: Data?, _ respuesta: URLResponse?, _ error: Error?) {
        DispatchQueue.main.async {
            guard error == nil else {
                self.respuesta.onDataError(message: "error http")
                return
            }
            guard let datos = data else {
                self.respuesta.onDataError(message: "error datos")
                return
            }
            self.respuesta.onData(data: datos)
        }
    }
    
    
}
