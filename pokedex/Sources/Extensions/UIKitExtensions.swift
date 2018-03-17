//
//  UIKitExtensions.swift
//  pokedex
//
//  Created by Ridho Pratama on 17/03/18.
//  Copyright © 2018 Ridho Pratama. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension UIScrollView {
    public var rx_reachedBottom: Observable<Void> {
        return rx.contentOffset
            .debounce(0.025, scheduler: MainScheduler.instance)
            .flatMap { [weak self] contentOffset -> Observable<Void> in
                guard let scrollView = self else {
                    return Observable.empty()
                }
                
                let visibleHeight = scrollView.frame.height - scrollView.contentInset.top - scrollView.contentInset.bottom
                let y = contentOffset.y + scrollView.contentInset.top
                let threshold = max(0.0, scrollView.contentSize.height - visibleHeight)
                
                return y >= threshold ? Observable.just(()) : Observable.empty()
        }
    }
}

extension UIImageView {
    func loadImage(fromUrl url: String) {
        DispatchQueue.global().async {
            // Create url from string address
            guard let url = URL(string: url) else {
                return
            }
            
            // Create data from url (You can handle exeption with try-catch)
            guard let data = try? Data(contentsOf: url) else {
                return
            }
            
            // Create image from data
            guard let image = UIImage(data: data) else {
                return
            }
            
            // Perform on UI thread
            DispatchQueue.main.async {
                self.image = image
                self.hideSkeleton()
            }
        }
    }
}
