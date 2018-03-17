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
            return CGSize(width: (width / 2.0) - 0.5, height: 100.0)
        }
        set {
            self.itemSize = newValue
        }
    }
    
    override var minimumLineSpacing: CGFloat {
        get { return 1.0 }
        set { self.minimumLineSpacing = newValue }
    }
    
    override var minimumInteritemSpacing: CGFloat {
        get { return 1.0 }
        set { self.minimumLineSpacing = newValue }
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return super.targetContentOffset(forProposedContentOffset: proposedContentOffset)
    }
}
