//
//  PokemonCell.swift
//  Pokedex
//
//  Created by Oscar Julian on 28/11/20.
//  Copyright © 2020 Oscar Julian Gil Bernal. All rights reserved.
//

import UIKit

class PokemonCell: UITableViewCell {

    @IBOutlet var lbpokemonname: UILabel!
    @IBOutlet var pokemonimage: UIImageView!
    @IBOutlet var lbcount: UILabel!
    @IBOutlet var labelType: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
