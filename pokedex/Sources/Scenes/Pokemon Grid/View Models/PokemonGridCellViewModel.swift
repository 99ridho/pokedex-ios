//
//  PokemonGridCellViewModel.swift
//  pokedex
//
//  Created by Ridho Pratama on 17/03/18.
//  Copyright © 2018 Ridho Pratama. All rights reserved.
//

import Foundation

struct PokemonGridCellViewModel {
    var name: String
    var spriteUrl: String
    
    init(withPokemonName name: String, index: Int) {
        self.name = name.capitalized
        self.spriteUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(index).png"
    }
}
