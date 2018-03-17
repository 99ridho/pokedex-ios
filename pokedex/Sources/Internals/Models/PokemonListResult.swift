//
//  PokemonListResult.swift
//  pokedex
//
//  Created by Ridho Pratama on 13/03/18.
//  Copyright © 2018 Ridho Pratama. All rights reserved.
//

import Foundation
import Unbox

struct PokemonListResult {
    var url: String
    var name: String
}

extension PokemonListResult: Unboxable {
    init(unboxer: Unboxer) throws {
        self.url = try unboxer.unbox(key: "url")
        self.name = try unboxer.unbox(key: "name")
    }
}
