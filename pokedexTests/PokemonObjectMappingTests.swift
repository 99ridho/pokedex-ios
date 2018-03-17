//
//  PokemonObjectMappingTests.swift
//  pokedexTests
//
//  Created by Ridho Pratama on 17/03/18.
//  Copyright © 2018 Ridho Pratama. All rights reserved.
//

import XCTest
import Moya
import RxSwift
import RxCocoa
import RxTest

@testable import pokedex

class PokemonObjectMappingTests: XCTestCase {
    
    var provider: MoyaProvider<PokemonTarget>!
    var networkProvider: PokemonNetworkProvider!
    
    let disposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        
        provider = MoyaProvider<PokemonTarget>(stubClosure: MoyaProvider.immediatelyStub)
        networkProvider = PokemonNetworkProvider(provider: provider)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPokemonListCorrectMapping() {
        networkProvider.requestPokemonList(withOffset: 0)
            .subscribe(onNext: { response in
                let first = response[0]
                
                XCTAssertEqual(first.name, "bulbasaur")
            })
            .disposed(by: disposeBag)
    }
}
