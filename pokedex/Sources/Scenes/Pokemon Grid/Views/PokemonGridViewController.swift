//
//  PokemonGridViewController.swift
//  pokedex
//
//  Created by Ridho Pratama on 17/03/18.
//  Copyright © 2018 Ridho Pratama. All rights reserved.
//

import UIKit
import Moya
import RxCocoa
import RxSwift

class PokemonGridViewController: UIViewController {
    let collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: GridCollectionViewLayout())
        cv.register(PokemonGridCollectionViewCell.self, forCellWithReuseIdentifier: PokemonGridCollectionViewCell.cellIdentifier)
        cv.backgroundColor = UIColor.white
        cv.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        
        return cv
    }()
    
    let vm = PokemonGridViewModel(withNetworkProvider: PokemonNetworkProvider())
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        title = "Pokedex"
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
        }
        
        bindViewModelToCollectionView()
    }
    
    func bindViewModelToCollectionView() {
        let vmInput = PokemonGridViewModel.Input(endOfCollectionViewTrigger: collectionView.rx_reachedBottom.asDriverOnErrorJustComplete(),
                                                 itemDidSelect: collectionView.rx.itemSelected.asDriver())
        let output = vm.transform(fromInput: vmInput)
        
        output.pokemonCellsViewModel
            .drive(collectionView.rx.items) { collectionView, index, cellViewModel in
                let indexPath = IndexPath(row: index, section: 0)
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonGridCollectionViewCell.cellIdentifier, for: indexPath) as! PokemonGridCollectionViewCell

                cell.bind(withViewModel: cellViewModel)

                return cell
            }
            .disposed(by: disposeBag)
        
        output.selectedPokemon
            .drive(onNext: { pokemon in
                print("selected pokemon: ", pokemon)
            })
            .disposed(by: disposeBag)
    }

}
