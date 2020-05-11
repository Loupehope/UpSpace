//
//  NextLaunchesViewController.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 22/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import RxCocoa
import RxOptional
import RxSwift
import TableKit
import UIKit

final class LaunchesViewController: BaseTableViewController<LaunchesViewModel> {
    private lazy var tableDirector = TableDirector(tableView: contentView)
    
    var navController: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.contentInset = .tableViewContentInset
        
        tableDirector.clearTableView()
        addRefreshControl()
        addBottomRefreshControl()
        bindViewModel()
        
        viewModel.startRefresh()
    }
}

// MARK: - Private

private extension LaunchesViewController {
    func updateLaunches(with list: [Launch]) {
        let rows = viewModel.createRows(for: list, with: didSelectRow(for:))
        tableDirector.appendSection(.create(with: rows), with: .fade)
        
        viewModel.didScrollToTop()
        viewModel.stopRefresh()
    }
    
    func didSelectRow(for item: Launch) {
        let infoLaunchController = InfoLaunchViewController(viewModel: .init(launch: item))
        navController?.pushViewController(infoLaunchController, animated: true)
    }
}

private extension LaunchesViewController {
    func addRefreshControl() {
        let refreshControl = CosmosRefreshControl()
        contentView.refreshControl = refreshControl
        bind(refreshControl: refreshControl, with: contentView)
        
        //HACK: fix incorrect refreshControl tintColor
        contentView.contentOffset = CGPoint(x: .zero, y: -refreshControl.frame.size.height)
    }
    
    func addBottomRefreshControl() {
        let activityView: CosmosActivityView = .default
        contentView.tableFooterView = activityView
        bindScrollToBottom(activityView: activityView, for: contentView)
    }
}

private extension LaunchesViewController {
    var launchesBinder: Binder<LaunchList?> {
        Binder(self) { base, list in
            base.updateLaunches(with: list?.launches ?? [])
        }
    }
    
    var refreshLaunchesBinder: Binder<Bool> {
        Binder(self) { base, _ in
            base.tableDirector.clearTableView()
        }
    }
    
    func bindViewModel() {
        viewModel.onLaunchesLoadObservable
            .observeOn(MainScheduler.asyncInstance)
            .skip(1)
            .bind(to: launchesBinder)
            .disposed(by: disposeBag)
        
        viewModel.isRefreshingObservable
            .observeOn(MainScheduler.asyncInstance)
            .filter { $0 }
            .bind(to: refreshLaunchesBinder)
            .disposed(by: disposeBag)
    }
}

private extension UIEdgeInsets {
    static let tableViewContentInset = UIEdgeInsets(top: 48, left: 0, bottom: 2, right: 0)
}
