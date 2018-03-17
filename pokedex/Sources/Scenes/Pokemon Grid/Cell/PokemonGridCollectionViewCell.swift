//
//  PokemonGridCollectionViewCell.swift
//  pokedex
//
//  Created by Ridho Pratama on 17/03/18.
//  Copyright © 2018 Ridho Pratama. All rights reserved.
//

import UIKit
import SnapKit
import SkeletonView

class PokemonGridCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "pokemon_grid_cell_id"
    
    let spriteImageView: UIImageView = UIImageView()
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
        label.textAlignment = .center
        label.textColor = UIColor.black.withAlphaComponent(0.7)
        
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    init(withName name: String, spriteUrl: String) {
        super.init(frame: CGRect.zero)
        nameLabel.text = name
        commonInit()
    }
    
    private func commonInit() {
        spriteImageView.isSkeletonable = true
        
        backgroundColor = UIColor.white
        addSubview(nameLabel)
        addSubview(spriteImageView)
        
        spriteImageView.snp.makeConstraints { make in
            make.width.equalTo(70)
            make.height.equalTo(70)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(5)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(20)
        }
        
        spriteImageView.showSkeleton()
        
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.black.withAlphaComponent(0.7).cgColor
        layer.cornerRadius = 3.0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func bind(withViewModel viewModel: PokemonGridCellViewModel) {
        self.nameLabel.text = viewModel.name
        self.spriteImageView.loadImage(fromUrl: viewModel.spriteUrl)
    }
}
