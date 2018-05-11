//
//  PokemonGridViewModel.swift
//  pokedex
//
//  Created by Ridho Pratama on 17/03/18.
//  Copyright © 2018 Ridho Pratama. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

struct PokemonGridViewModel: ViewModel {
    struct Input {
        let endOfCollectionViewTrigger: Driver<Void>
        let itemDidSelect: Driver<IndexPath>
    }
    
    struct Output {
        let pokemonCellsViewModel: Driver<[PokemonGridCellViewModel]>
        let selectedPokemon: Driver<Pokemon>
    }
    
    var networkProvider: PokemonNetworkProvider
    let disposeBag = DisposeBag()
    
    init(withNetworkProvider networkProvider: PokemonNetworkProvider) {
        self.networkProvider = networkProvider
    }
    
    func transform(fromInput input: PokemonGridViewModel.Input) -> PokemonGridViewModel.Output {
        let page = BehaviorRelay<Int>(value: 0)
        let items = BehaviorRelay<[PokemonListResult]>(value: [])
        let nextPageAvailable = BehaviorRelay<Bool>(value: true)
        
        let nextPageTrigger = input.endOfCollectionViewTrigger.withLatestFrom(nextPageAvailable.asDriver())
            .flatMapLatest { (available) -> Driver<Void> in
                return available ? Driver.just(()) : Driver.empty()
            }
        
        let results = nextPageTrigger
            .withLatestFrom(page.asDriver())
            .flatMapLatest { p -> Driver<[PokemonListResult]> in
                return self.networkProvider
                    .requestPokemonList(withOffset: p * 20)
                    .asDriverOnErrorJustComplete()
            }
            .map { result -> [PokemonListResult] in
                items.accept(items.value + result)
                page.accept(page.value + 1)
                nextPageAvailable.accept(!result.isEmpty)
                
                return items.value
            }
        
        let pokemonDetailCellViewModels = results.map {
            $0.enumerated().map {
                PokemonGridCellViewModel(withPokemonName: $1.name, index: $0 + 1)
            }
        }
        
        let selectedPokemon = input.itemDidSelect
            .withLatestFrom(results) { (indexPath, results) -> String in
                return results[indexPath.row].name
            }
            .flatMapLatest {
                return self.networkProvider
                    .requestPokemonDetail(withName: $0)
                    .asDriverOnErrorJustComplete()
            }
        
        return Output(pokemonCellsViewModel: pokemonDetailCellViewModels,
                      selectedPokemon: selectedPokemon)
    }
}
