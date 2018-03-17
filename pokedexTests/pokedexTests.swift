//
//  pokedexTests.swift
//  pokedexTests
//
//  Created by Ridho Pratama on 09/03/18.
//  Copyright © 2018 Ridho Pratama. All rights reserved.
//

import XCTest
import RxCocoa
import RxSwift
import RxTest

@testable import pokedex

class pokedexTests: XCTestCase {
    let db = DisposeBag()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
