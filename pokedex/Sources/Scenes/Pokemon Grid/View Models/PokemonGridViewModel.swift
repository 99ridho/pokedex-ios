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
        var endOfCollectionViewTrigger: Driver<Void>
    }
    
    struct Output {
        var pokemonCellsViewModel: Driver<[PokemonGridCellViewModel]>
    }
    
    var networkProvider: PokemonNetworkProvider
    let disposeBag = DisposeBag()
    
    init(withNetworkProvider networkProvider: PokemonNetworkProvider) {
        self.networkProvider = networkProvider
    }
    
    func transform(fromInput input: PokemonGridViewModel.Input) -> PokemonGridViewModel.Output {
        let page = BehaviorRelay<Int>(value: 0)
        let items = BehaviorRelay<[PokemonListResult]>(value: [])
        
        input.endOfCollectionViewTrigger
            .withLatestFrom(page.asDriver())
            .flatMapLatest { page -> Driver<[PokemonListResult]> in
                return self.networkProvider
                    .requestPokemonList(withOffset: page * 20)
                    .asDriver(onErrorJustReturn: [])
            }
            .drive(onNext: {
                items.accept(items.value + $0)
                page.accept(page.value + 1)
            })
            .disposed(by: disposeBag)
        
        let pokemonDetailCellViewModels = items.asDriver().map {
            $0.enumerated().map {
                PokemonGridCellViewModel(withPokemonName: $1.name, index: $0 + 1)
            }
        }
        
        return Output(pokemonCellsViewModel: pokemonDetailCellViewModels)
    }
}
