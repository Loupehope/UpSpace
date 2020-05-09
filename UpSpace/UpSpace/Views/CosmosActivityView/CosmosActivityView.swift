//
//  CosmosActivityView.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 06.05.2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

final class CosmosActivityView: UIActivityIndicatorView {
    private let isAnimatingRelay = PublishRelay<Bool>()
    
    var isAnimatingObservable: Observable<Bool> {
        isAnimatingRelay.asObservable()
    }
    
    override func startAnimating() {
        super.startAnimating()
        
        isAnimatingRelay.accept(true)
    }
    
    override func stopAnimating() {
        super.stopAnimating()
        
        isAnimatingRelay.accept(false)
    }
}

extension CosmosActivityView {
    static var `default`: CosmosActivityView {
        let activityView = CosmosActivityView()
        activityView.frame.size = .init(width: activityView.frame.width, height: .defaultHeight)
        activityView.color = .whiteSpace
        return activityView
    }
}
