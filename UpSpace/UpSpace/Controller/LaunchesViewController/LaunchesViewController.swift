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
import SnapKit
import TableKit
import UIKit

final class LaunchesViewController: BaseTableViewController<LaunchesViewModel> {
    private let initialSpinner = UIActivityIndicatorView(appearance: .init(size: .large))
    
    private lazy var tableDirector = TableDirector(tableView: contentView)
    
    var navController: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.contentInset = .tableViewContentInset
        
        tableDirector.clearTableView()
        
        addRefreshControl()
        addBottomRefreshControl()
        addInitialSpinner()
        
        bindViewModel()
        
        initialSpinner.startAnimating()
        viewModel.handleRefresh()
    }
    
    private func addInitialSpinner() {
        contentView.addSubview(initialSpinner)
    
        initialSpinner.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
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
    
    func didSelectRow(for item: Launch?) {
        // MOCK - Feature
    }
}

private extension LaunchesViewController {
    func addRefreshControl() {
        let refreshControl = UIRefreshControl(color: .whiteSpace)
        contentView.refreshControl = refreshControl
        
        refreshControl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
    }
    
    @objc func refreshAction() {
        CFRunLoopPerformBlock(CFRunLoopGetMain(), CFRunLoopMode.defaultMode.rawValue) { [weak self] in
            self?.viewModel.handleRefresh()
        }
    }
    
    func addBottomRefreshControl() {
        let activityView: CosmosActivityView = .default
        contentView.tableFooterView = activityView
        bindScrollToBottom(activityView: activityView, for: contentView)
    }
}

private extension LaunchesViewController {
    var launchesBinder: Binder<LaunchListProtocol?> {
        Binder(self) { base, list in
            base.updateLaunches(with: list?.launches ?? [])
            base.contentView.refreshControl?.endRefreshing()
            base.initialSpinner.stopAnimating()
        }
    }
    
    func bindViewModel() {
        viewModel.onLaunchesLoadObservable
            .observeOn(MainScheduler.asyncInstance)
            .skip(1)
            .bind(to: launchesBinder)
            .disposed(by: disposeBag)
    }
}

private extension UIEdgeInsets {
    static let tableViewContentInset = UIEdgeInsets(top: 48, left: 0, bottom: 2, right: 0)
}
