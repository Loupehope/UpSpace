//
//  CosmosRefreshControl.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 05.05.2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

final class CosmosRefreshControl: UIRefreshControl {
    private let isRefreshRelay = BehaviorRelay(value: false)
    
    var isRefreshObservable: Observable<Bool> {
        isRefreshRelay.asObservable()
    }
    
    override init() {
        super.init()
        
        configureUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        tintColor = .white
    }
    
    override func beginRefreshing() {
        super.beginRefreshing()
        
        isRefreshRelay.accept(true)
    }
    
    override func endRefreshing() {
        super.endRefreshing()
        
        isRefreshRelay.accept(false)
    }
}
