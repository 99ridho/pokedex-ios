//
//  ViewModel.swift
//  pokedex
//
//  Created by Ridho Pratama on 10/03/18.
//  Copyright © 2018 Ridho Pratama. All rights reserved.
//

import Foundation

protocol ViewModel {
    associatedtype Input
    associatedtype Output
    
    func transform(fromInput input: Input) -> Output
}
