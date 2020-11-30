//
//  Move.swift
//  Pokedex
//
//  Created by Oscar Julian on 28/11/20.
//  Copyright © 2020 Oscar Julian Gil Bernal. All rights reserved.
//

import Foundation


struct Move : Codable {
    
    var name : String
    var url : String
   
    
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
}

class MoveBLL{
    
    typealias ResponseHandler = (Array<Move>?,String, Bool) -> Void

    //Consulta con la API los items, dado el caso de tener algun tipo de logica de negocio se debe realizar aca
    func getAll(handler : @escaping ResponseHandler){

       NetworkManager.getAllMoveServer(endPoint: "move",  completionHandler: { (data, responseMessage, success) -> Void in
           if success {
              handler(data, responseMessage, success)
           } else {
               handler(nil, responseMessage, success)
           }
       })
    }
    
}
