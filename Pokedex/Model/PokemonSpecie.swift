//
//  PokemonSpecie.swift
//  Pokedex
//
//  Created by Oscar Julian on 29/11/20.
//  Copyright © 2020 Oscar Julian Gil Bernal. All rights reserved.
//

import Foundation


struct PokemonSpecie : Codable{
    
    var description : String
 
    
    init?(json: [String: AnyObject]) {

        //Saca el array de descripciones
        let flavor_text_entries = json["flavor_text_entries"]  as! Array<Any>
        //Toma el primer array
        let item = flavor_text_entries[0] as! [String : AnyObject]
        
        guard
            let description = item["flavor_text"] as? String
        
        else {
            return nil
        }
    
        self.description = description
    }
    
    init(description : String){
       self.description = description
    }
}
