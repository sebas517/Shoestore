//
//  OnResponse.swift
//  Shoestore
//
//  Created by dam on 6/2/19.
//  Copyright © 2019 dam. All rights reserved.
//

import Foundation

protocol OnResponse {
    func onData(data: Data)
    func onDataError(message: String)
}
