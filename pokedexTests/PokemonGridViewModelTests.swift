//
//  PokemonGridViewModelTests.swift
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

class PokemonGridViewModelTests: XCTestCase {
    
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
    
    func testRequestPokemonDetailsWhenReachBottomGrid() {
        let testScheduler = TestScheduler(initialClock: 0)
        let mockReachBottomGridTriggerEvents: [Recorded<Event<Void>>] = [
            Recorded.next(100, ()),
            Recorded.next(150, ()),
            Recorded.next(200, ()),
            Recorded.next(250, ())
        ]
        let mockReachBottomGridTrigger = testScheduler.createHotObservable(mockReachBottomGridTriggerEvents)
        let observer = testScheduler.createObserver([PokemonGridCellViewModel].self)
     
        let vm = PokemonGridViewModel(withNetworkProvider: self.networkProvider)
        let vmInput = PokemonGridViewModel.Input(endOfCollectionViewTrigger: mockReachBottomGridTrigger.asDriver(onErrorJustReturn: ()))
        let vmOutput = vm.transform(fromInput: vmInput)
       
        testScheduler.scheduleAt(0) { [unowned self] in
            vmOutput.pokemonCellsViewModel.drive(observer).disposed(by: self.disposeBag)
        }
        
        testScheduler.start()
        
        print(observer.events)
        XCTAssertEqual(observer.events.count * 20, 100)
    }
}
