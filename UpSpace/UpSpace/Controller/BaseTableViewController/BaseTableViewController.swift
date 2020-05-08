//
//  BaseTableViewController.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 04.05.2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

import DeviceKit
import RxCocoa
import RxSwift
import UIKit

class BaseTableViewController<ViewModelT: BaseTableViewModel>: BaseViewController<ViewModelT, UITableView> {
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.configureCosmosTableView()
    }
}

extension BaseTableViewController {
    func bind(refreshControl: CosmosRefreshControl, with tableView: UITableView) {
        viewModel.isRefreshingDriver
            .drive(refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
        
        viewModel.bind(refreshRequestObservable: refreshControl.isRefreshObservable)
            .disposed(by: disposeBag)
        
        tableView.rx
            .contentOffset
            .asObservable()
            .filter { $0.y < .ptrOffset && !tableView.isDecelerating && !refreshControl.isRefreshing }
            .bind(to: refreshBinder)
            .disposed(by: disposeBag)
    }
    
    func bindScrollToBottom(activityView: CosmosActivityView,
                            for tableView: UITableView,
                            with edgeOffset: CGFloat = -.defaultHeight) {
        viewModel.isBottomObservable
            .observeOn(MainScheduler.asyncInstance)
            .do(onNext: { [weak contentView] in
                contentView?.tableFooterView = $0 ? activityView : UIView(frame: .zero)
            })
            .bind(to: activityView.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel.bind(loadMoreRequestObservable: activityView.isAnimatingObservable)
            .disposed(by: disposeBag)
        
        tableView.rx
            .willDisplayCell
            .distinctUntilChanged { $0.indexPath == $1.indexPath }
            .map { [weak contentView] in
                guard let contentView = contentView else {
                    return false
                }
                
                let lastSection = contentView.numberOfSections - 1
                let lastCell = contentView.numberOfRows(inSection: lastSection) - 1
                let intexPath = IndexPath(row: lastCell, section: lastSection)
                
                return $0.indexPath == intexPath && !activityView.isAnimating
            }
            .filter { $0 }
            .bind(to: bottomBinder)
            .disposed(by: disposeBag)
    }
}

private extension BaseTableViewController {
    var refreshBinder: Binder<CGPoint> {
        Binder(self) { base, _ in
            base.viewModel.startRefresh()
        }
    }
    
    var bottomBinder: Binder<Bool> {
        Binder(self) { base, _ in
            base.viewModel.didScrollToBottom()
        }
    }
}

private extension CGFloat {
    static var ptrOffset: CGFloat {
        Device.isSmallScreen ? -110 : -140
    }
}
