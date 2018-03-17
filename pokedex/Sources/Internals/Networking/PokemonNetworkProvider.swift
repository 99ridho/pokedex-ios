//
//  PokemonNetworkProvider.swift
//  pokedex
//
//  Created by Ridho Pratama on 13/03/18.
//  Copyright © 2018 Ridho Pratama. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import Unbox

struct PokemonNetworkProvider {
    
    var provider: MoyaProvider<PokemonTarget>
    
    init(provider: MoyaProvider<PokemonTarget> = MoyaProvider<PokemonTarget>()) {
        self.provider = provider
    }
    
    func requestPokemonList(withOffset offset: Int) -> Observable<[PokemonListResult]> {
        return provider.rx
            .request(.requestPokemonList(offset: offset))
            .asObservable()
            .filterSuccessfulStatusAndRedirectCodes()
            .mapJSON()
            .map { json -> [PokemonListResult] in
                let dict = json as! [String:Any]
                
                let res: [PokemonListResult] = try unbox(dictionary: dict, atKey: "results")
                return res
            }
    }
    
    func requestPokemonDetail(withName name: String) -> Observable<Pokemon> {
        return provider.rx
            .request(.requestPokemonDetail(name: name))
            .asObservable()
            .filterSuccessfulStatusAndRedirectCodes()
            .mapJSON()
            .map { json -> Pokemon in
                let dict = json as! [String:Any]
                
                let res: Pokemon = try unbox(dictionary: dict)
                return res
            }
    }
    
}
