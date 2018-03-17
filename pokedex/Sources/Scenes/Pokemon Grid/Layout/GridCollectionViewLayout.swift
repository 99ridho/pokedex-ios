//
//  GridCollectionViewLayout.swift
//  pokedex
//
//  Created by Ridho Pratama on 17/03/18.
//  Copyright © 2018 Ridho Pratama. All rights reserved.
//

import UIKit

class GridCollectionViewLayout: UICollectionViewFlowLayout {
    override var itemSize: CGSize {
        get {
            let width = UIScreen.main.bounds.size.width
            let height = collectionView?.bounds.height ?? 0
            return CGSize(width: (width / 2.0) - 15, height: height / 5)
        }
        set {
            self.itemSize = newValue
        }
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return super.targetContentOffset(forProposedContentOffset: proposedContentOffset)
    }
}
