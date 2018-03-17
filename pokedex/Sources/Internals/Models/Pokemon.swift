//
//  Pokemon.swift
//  pokedex
//
//  Created by Ridho Pratama on 09/03/18.
//  Copyright © 2018 Ridho Pratama. All rights reserved.
//

import Foundation
import Unbox

struct Pokemon {
    struct Stat {
        var name: String
        var baseStat: Int
    }
    
    var name: String
    var weight: Int
    var baseExperience: Int
    var abilities: [String]
    var types: [String]
    var spriteUrl: String
    var stats: [Stat]
}

extension Pokemon.Stat: Unboxable {
    init(unboxer: Unboxer) throws {
        self.name = try unboxer.unbox(keyPath: "stat.name")
        self.baseStat = try unboxer.unbox(key: "base_stat")
    }
}

extension Pokemon: Unboxable {
    init(unboxer: Unboxer) throws {
        self.name = try unboxer.unbox(key: "name")
        self.weight = try unboxer.unbox(key: "weight")
        self.baseExperience = try unboxer.unbox(key: "base_experience")
        self.stats = try unboxer.unbox(key: "stats")
        self.spriteUrl = try unboxer.unbox(keyPath: "sprites.front_default")
        
        let unboxedAbilities: [[String:Any]] = try unboxer.unbox(key: "abilities")
        let unboxedTypes: [[String:Any]] = try unboxer.unbox(key: "types")
        
        self.abilities = unboxedAbilities.map {
            guard let abilityDict = $0["ability"] as? [String:String] else {
                return ""
            }
            
            return abilityDict["name"] ?? ""
        }
        self.types = unboxedTypes.map {
            guard let typesDict = $0["type"] as? [String:String] else {
                return ""
            }
            
            return typesDict["name"] ?? ""
        }
    }
}
