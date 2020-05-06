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
            .filter { $0.y < .ptrOffset && !tableView.isDecelerating && !refreshControl.isRefreshing }
            .bind(to: refreshBinder)
            .disposed(by: disposeBag)
    }
    
    func bindScrollToBottom(for tableView: UITableView, with edgeOffset: CGFloat = 20.0) {
        tableView.rx
            .contentOffset
            .asVoid()
            .map { tableView.isBottomPTRAvailable(offset: edgeOffset) }
            .distinctUntilChanged()
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
        Binder(self) { base, isBottom in
            if isBottom {
                base.viewModel.didScrollToBottom()
            } else {
                base.viewModel.didScrollToTop()
            }
        }
    }
}

private extension CGFloat {
    static var ptrOffset: CGFloat {
        Device.isSmallScreen ? -110 : -140
    }
}
