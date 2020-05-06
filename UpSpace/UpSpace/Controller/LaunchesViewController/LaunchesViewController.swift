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
        
        contentView.contentInset = UIEdgeInsets(top: 48, left: 0, bottom: 2, right: 0)
        tableDirector.clearTableView()
        addRefreshControl()
        bindViewModel()
        viewModel.startRefresh()
    }
}

// MARK: - Private

private extension LaunchesViewController {
    func updateLaunches(with list: [Launch]) {
        let rows = list.map {
            TableRow<NextLaunchCell>(item: .init(launch: $0))
                .on(.click) { [weak self] in
                    self?.didSelectRow(for: $0.item.launch)
                }
        }
        
        tableDirector.replaceSection(at: .zero, with: .create(with: rows), and: .fade)
        viewModel.stopRefresh()
    }
    
    func didSelectRow(for item: Launch?) {
        // MOCK - Feature
    }
    
    func refreshLaunches() {
        tableDirector.clearTableView()
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
}

private extension LaunchesViewController {
    var launchesBinder: Binder<LaunchListProtocol> {
        Binder(self) { base, list in
            base.updateLaunches(with: list.launches)
        }
    }
    
    var refreshLaunchesBinder: Binder<Bool> {
        Binder(self) { base, _ in
            base.refreshLaunches()
        }
    }
    
    func bindViewModel() {
        viewModel.onLaunchesLoadObservable
            .observeOn(MainScheduler.asyncInstance)
            .skip(1)
            .filterNil()
            .bind(to: launchesBinder)
            .disposed(by: disposeBag)
        
        viewModel.isRefreshingObservable
            .observeOn(MainScheduler.asyncInstance)
            .filter { $0 }
            .bind(to: refreshLaunchesBinder)
            .disposed(by: disposeBag)
    }
}
