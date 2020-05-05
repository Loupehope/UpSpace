//
//  BaseTableViewModel.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 05.05.2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class BaseTableViewModel: ViewModel {
    private let isRefreshingRelay = PublishRelay<Bool>()
    private let isBottomRelay = PublishRelay<Bool>()
}

// MARK: - PTR

extension BaseTableViewModel {
    var isRefreshingDriver: Driver<Bool> {
        isRefreshingRelay.asDriver(onErrorJustReturn: false)
    }
    
    var isRefreshingObservable: Observable<Bool> {
        isRefreshingRelay.asObservable()
    }
    
    func startRefresh() {
        isRefreshingRelay.accept(true)
    }
    
    func stopRefresh() {
        isRefreshingRelay.accept(false)
    }
}

// MARK: - Bottom Activity

extension BaseTableViewModel {
    var isBottomDriver: Driver<Bool> {
        isBottomRelay.asDriver(onErrorJustReturn: false)
    }
    
    func didScrollToBottom() {
        isBottomRelay.accept(true)
    }
    
    func didScrollToTop() {
        isBottomRelay.accept(false)
    }
}
