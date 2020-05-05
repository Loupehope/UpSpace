//
//  BaseTableViewController.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 04.05.2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

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
    func bind(refreshControl: UIRefreshControl, with tableView: UITableView) {
        let refreshRequestObservable = refreshControl.rx
            .controlEvent(.valueChanged)
            .asObservable()
        
        viewModel.isRefreshingDriver
            .drive(refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
        
        viewModel.bind(refreshRequestObservable: refreshRequestObservable)
            .disposed(by: disposeBag)
        
        tableView.rx
            .contentOffset
            .filter { $0.y < -160 && !refreshControl.isRefreshing }
            .bind { [weak self] _ in
                self?.viewModel.startRefresh()
            }
            .disposed(by: disposeBag)
    }
    
    func bindScrollToBottom(for tableView: UITableView, with edgeOffset: CGFloat = 20.0) {
        tableView.rx
            .contentOffset
            .map { _ in
                tableView.isNearBottomEdge(edgeOffset: edgeOffset) &&
                    !(tableView.refreshControl?.isRefreshing ?? false)
            }
            .distinctUntilChanged()
            .bind { [weak viewModel] isBottom in
                if isBottom {
                    viewModel?.didScrollToBottom()
                } else {
                    viewModel?.didScrollToTop()
                }
            }
            .disposed(by: disposeBag)
    }
}
