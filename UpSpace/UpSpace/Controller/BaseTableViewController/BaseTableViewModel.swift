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
    private let isBottomRelay = PublishRelay<Bool>()
    
    func handleRefresh() {
        // override
    }
    
    func handleLoadMore() {
        // override
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
