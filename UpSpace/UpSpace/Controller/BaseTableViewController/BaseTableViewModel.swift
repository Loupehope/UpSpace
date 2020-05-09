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
    
    func handleRefresh() {
        // override
    }
    
    func handleLoadMore() {
        // override
    }
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
    
    func bind(refreshRequestObservable: Observable<Bool>) -> Disposable {
        refreshRequestObservable.concat(isRefreshingObservable)
            .filter { $0 }
            .bind { [weak self] _ in
                self?.handleRefresh()
            }
    }
}

// MARK: - Bottom Activity
extension BaseTableViewModel {
    var isBottomObservable: Observable<Bool> {
        isBottomRelay.asObservable()
    }
    
    func didScrollToBottom() {
        isBottomRelay.accept(true)
    }
    
    func didScrollToTop() {
        isBottomRelay.accept(false)
    }
    
    func bind(loadMoreRequestObservable: Observable<Bool>) -> Disposable {
        loadMoreRequestObservable.withLatestFrom(isBottomRelay)
            .filter { $0 }
            .bind { [weak self] _ in
                self?.handleLoadMore()
            }
    }
}
