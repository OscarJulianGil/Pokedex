//
//  ViewController.swift
//  Pokedex
//
//  Created by Oscar Julian on 27/11/20.
//  Copyright © 2020 Oscar Julian Gil Bernal. All rights reserved.
//

import UIKit

class PokemonController: ParentController{

    @IBOutlet var table: UITableView!
    
    var pokemon = PokemonBLL()
    var info = [Pokemon]()
    var nameSelected : Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        table.register(UINib(nibName: "PokemonCell", bundle: nil), forCellReuseIdentifier: "PokemonCell")
        loadItems()
    }
    
    func loadItems(){
        info = [Pokemon]()
        info.removeAll()
        Util.showSpinner()
        pokemon.getAll (handler: { (data, responseMessage, success) -> Void in
            // When api request completes,control flow goes here.
            Util.stopSpinner()
            if success {
                if let infopokemon = data{
                    self.loaddetail(data : infopokemon)
                }
            } else {
                self.showUserMessage(usermessage: responseMessage)
            }
        })
    }
    
    func loaddetail(data : [Pokemon] ){
        for item in data{
            pokemon.getdetail (url : item.url, handler: { (data, responseMessage, success) -> Void in
                // When api request completes,control flow goes here.
                Util.stopSpinner()
                if success {
                    self.info.append(Pokemon(name: item.name, url: item.url, detail : data!))
                    self.table.reloadData()
                } else {
                    self.showUserMessage(usermessage: responseMessage)
                }
            })
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "godetail"{
            let destination = segue.destination as! UINavigationController
            let targetController = destination.topViewController as! PokemonDetailController
            targetController.pokemonSelected = nameSelected
        }
    }
}

extension PokemonController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.info.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for : indexPath)
        as! PokemonCell
        
        cell.lbpokemonname.text = self.info[indexPath.row].name
        cell.lbcount.text = "#00\(String(self.info[indexPath.row].detail.id))"
        let url = URL(string: self.info[indexPath.row].detail.front_shiny)
   
        cell.pokemonimage.load(url: url!)
        
        var types : String = ""
        for type in self.info[indexPath.row].detail.types{
            types.append(type.name + " ")
        }
        cell.labelType.text = types
        return cell
    }
    
    
    
}

extension PokemonController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.nameSelected = self.info[indexPath.row]
        self.performSegue(withIdentifier: "godetail", sender: self)
    }
    
    
}

//MARK: - Extension para la barra de busqueda
extension PokemonController : UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       
        Util.showSpinner()
        pokemon.getByName (name: searchBar.text!, handler: { (data, responseMessage, success) -> Void in
          // When api request completes,control flow goes here.
          Util.stopSpinner()
          if success {
              if let infopokemon = data{
                self.info = [Pokemon]()
                self.info.removeAll()
                self.info.append(Pokemon(name: infopokemon.name, url: "", detail: infopokemon))
                self.table.reloadData()
              }
          } else {
            self.showUserMessage(usermessage: responseMessage)
          }
      })
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            loadItems();
            DispatchQueue.main.async {
               searchBar.resignFirstResponder()
            }
            
        }
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
