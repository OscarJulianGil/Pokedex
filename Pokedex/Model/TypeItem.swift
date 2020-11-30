//
//  Type.swift
//  Pokedex
//
//  Created by Oscar Julian on 29/11/20.
//  Copyright © 2020 Oscar Julian Gil Bernal. All rights reserved.
//

import Foundation


struct TypeItem : Codable{
    
    var slot : Int
    var name : String
    var url : String
    
    init(name : String, url : String, slot: Int){
        self.name = name
        self.url = url
        self.slot = slot
    }
}
