//
//  NetworkManager.swift
//  Pokedex
//
//  Created by Oscar Julian on 27/11/20.
//  Copyright © 2020 Oscar Julian Gil Bernal. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager{
    
    typealias CompletionHandlerPokemonResponse = (Array<Pokemon>?,String, Bool) -> Void
    typealias CompletionHandlerDetailResponse = (PokemonDetail?,String, Bool) -> Void
    
    typealias CompletionHandlerItemResponse = (Array<Item>?,String, Bool) -> Void
    typealias CompletionHandlerItemDetailResponse = (ItemDetail?,String, Bool) -> Void
    
    typealias CompletionHandlerMoveResponse = (Array<Move>?,String, Bool) -> Void
    
    typealias CompletionHandlerSpecieResponse = (PokemonSpecie?,String, Bool) -> Void
    
    ///Retorna toda la informacion de los pokemon
    static func getAllPokemonServer(endPoint : String,completionHandler: @escaping CompletionHandlerPokemonResponse){
        
        var Response = Array<Pokemon>()
        AF.request(Util.WEB_SERVER_URL + endPoint,
                      method: .get)
        .validate()
        .responseJSON { response in
            //success
            switch response.response?.statusCode {
            case 200:
                guard let json = response.value as? [String: AnyObject] else {
                    completionHandler(nil, NSLocalizedString("Error inesperado", comment: ""), false)
                    return
                }
                guard let dLogs = json["results"] as? Array<Any>
                    else {
                    completionHandler(nil, NSLocalizedString("Error inesperado", comment: ""), false)
                    return
                }
                for dlog in dLogs {
                    guard let EventLog = Pokemon(json: dlog  as! [String : AnyObject]) else {
                        completionHandler(nil, NSLocalizedString("Error inesperado", comment: ""), false)
                        return
                    }
                    Response.append(EventLog)
                }
                completionHandler(Response, "", true)
                break;
            case 404, 422, 500: //error
                completionHandler(nil, NSLocalizedString("Error inesperado", comment: ""), false)
                break;
            case .none://no connection to server
                completionHandler(nil, NSLocalizedString("Sin conexión", comment: ""), false)
                break;
            case .some(_):
                completionHandler(nil, NSLocalizedString("Error inesperado", comment: ""), false)
                break;
            }
        }
    }
    
    
    //Retorna el detalle de cada pokemon
    static func getPokemonDetailServer(url : String,completionHandler: @escaping CompletionHandlerDetailResponse){
        
        AF.request(url,
                      method: .get)
        .validate()
        .responseJSON { response in
            //success
            switch response.response?.statusCode {
            case 200:
                 guard let json =  response.value as? [String: AnyObject] else {
                   completionHandler(nil, NSLocalizedString("Error inesperado", comment: ""), false)
                   return
                 }
                 // turn JSON in to Parent object
                 guard let item = PokemonDetail(json: json ) else {
                    completionHandler(nil, NSLocalizedString("Error inesperado", comment: ""), false)
                    return
                 }
                
                completionHandler(item, "", true)
                break;
            case 404: //error
                completionHandler(nil, NSLocalizedString("Pokemon no encontrado", comment: ""), false)
                break;
            case 422, 500: //error
                completionHandler(nil, NSLocalizedString("Error inesperado", comment: ""), false)
                break;
            case .none://no connection to server
                completionHandler(nil, NSLocalizedString("Sin conexión", comment: ""), false)
                break;
            case .some(_):
                completionHandler(nil, NSLocalizedString("Error inesperado", comment: ""), false)
                break;
            }
        }
    }
    
    //Retorna todos los items
    static func getAllItemServer(endPoint : String,completionHandler: @escaping CompletionHandlerItemResponse){
        
        var Response = Array<Item>()
        AF.request(Util.WEB_SERVER_URL + endPoint,
                      method: .get)
        .validate()
        .responseJSON { response in
            //success
            switch response.response?.statusCode {
            case 200:
                guard let json = response.value as? [String: AnyObject] else {
                    completionHandler(nil, NSLocalizedString("Error inesperado", comment: ""), false)
                    return
                }
                guard let dLogs = json["results"] as? Array<Any>
                    else {
                    completionHandler(nil, NSLocalizedString("Error inesperado", comment: ""), false)
                    return
                }
                for dlog in dLogs {
                    guard let newitem = Item(json: dlog  as! [String : AnyObject]) else {
                        completionHandler(nil, NSLocalizedString("Error inesperado", comment: ""), false)
                        return
                    }
                    Response.append(newitem)
                }
                completionHandler(Response, "", true)
                break;
            case 404, 422, 500: //error
                completionHandler(nil, NSLocalizedString("Error inesperado", comment: ""), false)
                break;
            case .none://no connection to server
                completionHandler(nil, NSLocalizedString("Sin conexión", comment: ""), false)
                break;
            case .some(_):
                completionHandler(nil, NSLocalizedString("Error inesperado", comment: ""), false)
                break;
            }
        }
    }

    ///Retorna el detalle de cada una de las pokebolas
    static func getItemDetailServer(url : String,completionHandler: @escaping CompletionHandlerItemDetailResponse){
        
        AF.request(url,
                      method: .get)
        .validate()
        .responseJSON { response in
            //success
            switch response.response?.statusCode {
            case 200:
                 guard let json =  response.value as? [String: AnyObject] else {
                   completionHandler(nil, NSLocalizedString("Error inesperado", comment: ""), false)
                   return
                 }
                 // turn JSON in to Parent object
                 guard let item = ItemDetail(json: json ) else {
                    completionHandler(nil, NSLocalizedString("Error inesperado", comment: ""), false)
                    return
                 }
                
                completionHandler(item, "", true)
                break;
            case 404, 422, 500: //error
                completionHandler(nil, NSLocalizedString("Error inesperado", comment: ""), false)
                break;
            case .none://no connection to server
                completionHandler(nil, NSLocalizedString("Sin conexión", comment: ""), false)
                break;
            case .some(_):
                completionHandler(nil, NSLocalizedString("Error inesperado", comment: ""), false)
                break;
            }
        }
    }
    
    
    
    static func getAllMoveServer(endPoint : String,completionHandler: @escaping CompletionHandlerMoveResponse){
        
        var Response = Array<Move>()
        AF.request(Util.WEB_SERVER_URL + endPoint,
                      method: .get)
        .validate()
        .responseJSON { response in
            //success
            switch response.response?.statusCode {
            case 200:
                guard let json = response.value as? [String: AnyObject] else {
                    completionHandler(nil, NSLocalizedString("Error inesperado", comment: ""), false)
                    return
                }
                guard let dLogs = json["results"] as? Array<Any>
                    else {
                    completionHandler(nil, NSLocalizedString("Error inesperado", comment: ""), false)
                    return
                }
                for dlog in dLogs {
                    guard let newitem = Move(json: dlog  as! [String : AnyObject]) else {
                        completionHandler(nil, NSLocalizedString("Error inesperado", comment: ""), false)
                        return
                    }
                    Response.append(newitem)
                }
                completionHandler(Response, "", true)
                break;
            case 404, 422, 500: //error
                completionHandler(nil, NSLocalizedString("Error inesperado", comment: ""), false)
                break;
            case .none://no connection to server
                completionHandler(nil, NSLocalizedString("Sin conexión", comment: ""), false)
                break;
            case .some(_):
                completionHandler(nil, NSLocalizedString("Error inesperado", comment: ""), false)
                break;
            }
        }
    }
    
    static func getPokemonSpecie(url : String,completionHandler: @escaping CompletionHandlerSpecieResponse){
        
        AF.request(url,
                      method: .get)
        .validate()
        .responseJSON { response in
            //success
            switch response.response?.statusCode {
            case 200:
                 guard let json =  response.value as? [String: AnyObject] else {
                   completionHandler(nil, NSLocalizedString("Error inesperado", comment: ""), false)
                   return
                 }
                 // turn JSON in to Parent object
                 guard let item = PokemonSpecie(json: json ) else {
                    completionHandler(nil, NSLocalizedString("Error inesperado", comment: ""), false)
                    return
                 }
                
                completionHandler(item, "", true)
                break;
            case 404: //error
                completionHandler(nil, NSLocalizedString("Specie no encontrada", comment: ""), false)
                break;
            case 422, 500: //error
                completionHandler(nil, NSLocalizedString("Error inesperado", comment: ""), false)
                break;
            case .none://no connection to server
                completionHandler(nil, NSLocalizedString("Sin conexión", comment: ""), false)
                break;
            case .some(_):
                completionHandler(nil, NSLocalizedString("Error inesperado", comment: ""), false)
                break;
            }
        }
    }
    
}
