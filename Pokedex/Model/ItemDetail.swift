//
//  ItemDetail.swift
//  Pokedex
//
//  Created by Oscar Julian on 28/11/20.
//  Copyright © 2020 Oscar Julian Gil Bernal. All rights reserved.
//

import Foundation


struct ItemDetail : Codable{
    
    var image : String
    var cost : Int
    init?(json: [String: AnyObject]) {
        let sprites = json["sprites"]  as! [String : AnyObject]
        guard
            let image = sprites["default"] as? String,
        let cost = json["cost"] as? Int
        
        else {
            return nil
        }

        self.image = image
        self.cost = cost
    }
    
    init(image : String, cost : Int){
        self.image = image
        self.cost = cost
    }
}
