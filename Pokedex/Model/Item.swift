//
//  Item.swift
//  Pokedex
//
//  Created by Oscar Julian on 28/11/20.
//  Copyright © 2020 Oscar Julian Gil Bernal. All rights reserved.
//

import Foundation

struct Item : Codable{
    
     var name : String
     var url : String
     var detail : ItemDetail!
       
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
       
       init(name : String, url : String, detail : ItemDetail){
           self.name = name
           self.url = url
           self.detail = detail
       }
    
}

class ItemBLL {
    
    typealias ResponseHandler = (Array<Item>?,String, Bool) -> Void
    typealias ResponseDetailHandler = (ItemDetail?,String, Bool) -> Void
       
    //Consulta con la API los items, dado el caso de tener algun tipo de logica de negocio se debe realizar aca
    func getAll(handler : @escaping ResponseHandler){

       NetworkManager.getAllItemServer(endPoint: "item",  completionHandler: { (data, responseMessage, success) -> Void in
           if success {
              handler(data, responseMessage, success)
           } else {
               handler(nil, responseMessage, success)
           }
       })
    }
    
    ///Consulta la Api y retorna el detalle de cada pokemon, en caso de tener logica de negocio se debe realizar aca
    func getdetail(url : String, handler : @escaping ResponseDetailHandler){
        
        NetworkManager.getItemDetailServer(url: url,  completionHandler: { (itemdetail, responseMessage, success) -> Void in
            if success{
               handler(itemdetail, responseMessage, success)
            }
            else{
                handler(nil, responseMessage, success)
            }
        })
    }
}
