//
//  Pokemon.swift
//  Pokedex
//
//  Created by Oscar Julian on 28/11/20.
//  Copyright © 2020 Oscar Julian Gil Bernal. All rights reserved.
//

import Foundation
import Alamofire

struct Pokemon : Codable {
    
    var name : String
    var url : String
    var detail : PokemonDetail!

    init?(json: [String: AnyObject]) {
        guard
            let event_type = json["name"] as? String,
            let event_time = json["url"] as? String
        
        else {
            return nil
        }
    
        self.name = event_type
        self.url = event_time
    }
    
    init(name : String, url : String){
        self.name = name
        self.url = url
    }
    
    init(name : String, url : String, detail : PokemonDetail){
        self.name = name
        self.url = url
        self.detail = detail
    }
}

class PokemonBLL{
    
    typealias ResponseHandler = (Array<Pokemon>?,String, Bool) -> Void
    typealias ResponseDetailHandler = (PokemonDetail?,String, Bool) -> Void
    typealias ResponseSpecieHandler = (PokemonSpecie?,String, Bool) -> Void
    
    
    ///Consulta la API y retorna todos los pokemon
    func getAll(handler : @escaping ResponseHandler){

        NetworkManager.getAllPokemonServer(endPoint: "pokemon",  completionHandler: { (drvLogs, responseMessage, success) -> Void in
            if success {
               handler(drvLogs, responseMessage, success)                
            } else {
                handler(nil, responseMessage, success)
            }
        })
    }
    
    
    ///Consulta la Api y retorna el detalle de cada pokemon
    func getdetail(url : String, handler : @escaping ResponseDetailHandler){
        
        NetworkManager.getPokemonDetailServer(url: url,  completionHandler: { (itemdetail, responseMessage, success) -> Void in
            if success{
               handler(itemdetail, responseMessage, success)
            }
            else{
                handler(nil, responseMessage, success)
            }
        })
    }
    
    
    ///Retorna la informacion del pokemon por nombre
    func getByName(name : String, handler : @escaping ResponseDetailHandler){
        let endPopint = Util.WEB_SERVER_URL + "pokemon/\(name.lowercased())"
        NetworkManager.getPokemonDetailServer(url: endPopint,  completionHandler: { (itemdetail, responseMessage, success) -> Void in
            if success{
               handler(itemdetail, responseMessage, success)
            }
            else{
                handler(nil, responseMessage, success)
            }
        })
    }
    
    
    ///Retorna la descripcion del pokemon
    func getSpecieByName(name : String, handler : @escaping ResponseSpecieHandler){
        let endPopint = Util.WEB_SERVER_URL + "pokemon-species/\(name.lowercased())"
        NetworkManager.getPokemonSpecie(url: endPopint,  completionHandler: { (itemdetail, responseMessage, success) -> Void in
            if success{
               handler(itemdetail, responseMessage, success)
            }
            else{
                handler(nil, responseMessage, success)
            }
        })
    }

    
}
