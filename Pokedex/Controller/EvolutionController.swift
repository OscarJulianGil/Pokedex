//
//  EvolutionController.swift
//  Pokedex
//
//  Created by Oscar Julian on 29/11/20.
//  Copyright © 2020 Oscar Julian Gil Bernal. All rights reserved.
//

import UIKit

class EvolutionController: UIViewController {

    var pokemonSelected : Pokemon?
    
    @IBOutlet var labelTipo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let selected = pokemonSelected{
            var tipos : String = ""
            for item in selected.detail.types{
                tipos.append("\(item.name) \n")
            }
            labelTipo.text = tipos
           

        }
        // Do any additional setup after loading the view.
    }
    

   

}
