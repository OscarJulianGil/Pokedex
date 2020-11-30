//
//  NetworkProtocol.swift
//  Pokedex
//
//  Created by Oscar Julian on 27/11/20.
//  Copyright © 2020 Oscar Julian Gil Bernal. All rights reserved.
//

import Foundation

protocol NetworkProtocol {
    func serverResponse(data: Data?,urlresponse: URLResponse?,error: Error?)
}
