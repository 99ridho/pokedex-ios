//
//  PokemonTarget.swift
//  pokedex
//
//  Created by Ridho Pratama on 10/03/18.
//  Copyright © 2018 Ridho Pratama. All rights reserved.
//

import Foundation
import Moya

enum PokemonTarget {
    case requestPokemonList(offset: Int)
    case requestPokemonDetail(name: String)
}

extension PokemonTarget: TargetType {
    var baseURL: URL {
        return URL.init(string: "http://pokeapi.salestock.net/api/v2/")!
    }
    
    var path: String {
        switch self {
        case .requestPokemonDetail(let name):
            return "pokemon/\(name)"
        case .requestPokemonList(_):
            return "pokemon/"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        switch self {
        case .requestPokemonDetail(_):
            guard let url = Bundle.main.url(forResource: "pokemon_detail", withExtension: "json"),
                let data = try? Data(contentsOf: url) else {
                    return Data()
            }
            return data
        case .requestPokemonList(_):
            guard let url = Bundle.main.url(forResource: "pokemon_list", withExtension: "json"),
                let data = try? Data(contentsOf: url) else {
                    return Data()
            }
            return data
        }
    }
    
    var task: Task {
        switch self {
        case .requestPokemonList(let offset):
            return .requestParameters(parameters: ["offset":offset], encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
