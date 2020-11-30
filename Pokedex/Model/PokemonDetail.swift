//
//  PokemonDetail.swift
//  Pokedex
//
//  Created by Oscar Julian on 28/11/20.
//  Copyright © 2020 Oscar Julian Gil Bernal. All rights reserved.
//

import Foundation


struct PokemonDetail : Codable{
    
    var back_default : String
    var back_shiny: String
    var front_shiny: String
    var id : Int
    var name : String
    var abilities : [PokemonAbilitie]
    var moves : [Move]
    var types : [TypeItem]
    
    init?(json: [String: AnyObject]) {
        let sprites = json["sprites"]  as! [String : AnyObject]
        let other = sprites["other"] as! [String : AnyObject]
        let imageofficial = other["official-artwork"] as! [String : AnyObject]
        //Saca las habilidades
        abilities = [PokemonAbilitie]()
        moves = [Move]()
        types = [TypeItem]()
        let jsonabilities = json["abilities"] as! Array<Any>
        for item in jsonabilities{
            let obj = item as! [String : AnyObject]
            let obj1 = obj["ability"] as! [String : AnyObject]
            
            abilities.append(PokemonAbilitie(name: obj1["name"] as! String , url: obj1["url"] as! String))
        }
        
        //Saca los movimientos
        let jsonmove = json["moves"] as! Array<Any>
        for item in jsonmove{
            let obj = item as! [String : AnyObject]
            let obj1 = obj["move"] as! [String : AnyObject]
            
            moves.append(Move(name: obj1["name"] as! String , url: obj1["url"] as! String))
        }
        
        //Saca el tipo o los tipos
        let jsontype = json["types"] as! Array<Any>
        for item in jsontype{
               let obj = item as! [String : AnyObject]
               let obj1 = obj["type"] as! [String : AnyObject]
               
                types.append(TypeItem(name: obj1["name"] as! String , url: obj1["url"] as! String, slot: 1))
        }
        
        guard
            let event_type = sprites["back_default"] as? String,
            let event_time = sprites["back_shiny"] as? String,
            let front_shiny = imageofficial["front_default"] as? String,
            let id = json["id"] as? Int,
            let name = json["name"] as? String
        
        else {
            return nil
        }
    
        self.back_default = event_type
        self.back_shiny = event_time
        self.front_shiny = front_shiny
        self.id = id
        self.name = name
    }
    
    init(back_default : String, back_shiny : String, front_shiny : String, id : Int, name : String, abilities : [PokemonAbilitie], moves : [Move],types : [TypeItem]){
       self.back_default = back_default
       self.back_shiny = back_shiny
       self.front_shiny = front_shiny
       self.id = id
       self.name = name
       self.abilities = abilities
        self.moves = moves
        self.types = types
    }
}
