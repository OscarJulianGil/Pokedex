//
//  StatController.swift
//  Pokedex
//
//  Created by Oscar Julian on 29/11/20.
//  Copyright © 2020 Oscar Julian Gil Bernal. All rights reserved.
//

import UIKit

class StatController: UIViewController {

    var pokemonSelected : Pokemon?
    
    @IBOutlet var labelHabilidades: UILabel!
    @IBOutlet var labelMovimientos: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let selected = pokemonSelected{
            var todas : String = ""
            var moves : String = ""
            for abilitie in selected.detail.abilities{
                todas.append("\(abilitie.name) \n")
                labelHabilidades.text = todas
            }
            for move in selected.detail.moves{
                moves.append("\(move.name) \n")
                labelMovimientos.text = moves
            }

        }
        
    }
    

}
