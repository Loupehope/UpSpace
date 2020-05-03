//
//  NextLaunchesViewController.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 22/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Reusable
import TableKit
import UIKit

final class LaunchesViewController: UITableViewController {
    private lazy var tableDirector = TableDirector(tableView: tableView)
    
    private let refreshController: UIRefreshControl = {
        let controller = UIRefreshControl()
        controller.addTarget(self, action: #selector(refreshLaunchesData(_:)), for: .valueChanged)
        controller.tintColor = .white
        return controller
    }()
    
    private var launches: [Launch] = []
    
    var navController: UINavigationController?
    
    var viewModel: LaunchesViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.refreshControl = refreshController
        tableView.contentInset = UIEdgeInsets(top: 48, left: 0, bottom: 2, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -refreshController.frame.size.height)
        
        viewModel?.onLaunchesChanged = { [weak self] list in
            self?.updateRefreshing(isRefreshing: false)
            self?.updateLaunches(with: list?.launches ?? [])
        }

        tableDirector.clearTableView()
        viewModel?.loadMore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        refreshController.beginRefreshing()
    }
}

// MARK: Private

private extension LaunchesViewController {
    func updateLaunches(with list: [Launch]) {
        launches += list
        
        let rows = launches.map {
            TableRow<NextLaunchCell>(item: .init(launch: $0))
                .on(.click) { [weak self] in
                    self?.didSelectRow(for: $0.item.launch)
                }
        }
        
        tableDirector.replaceSection(with: .init(rows: rows), at: .zero)
    }
    
    func didSelectRow(for item: Launch?) {
        let controller = InfoLaunchViewController.instantiate()
        controller.launch = item
        navController?.pushViewController(controller, animated: true)
    }
    
    @objc func refreshLaunchesData(_ sender: Any) {
        launches = []
        tableDirector.clearTableView()
        viewModel?.update()
    }
}

private extension LaunchesViewController {
    func updateRefreshing(isRefreshing: Bool) {
        DispatchQueue.main.async { [weak self] in
            isRefreshing
                ? self?.refreshController.beginRefreshing()
                : self?.refreshController.endRefreshing()
        }
    }
}

// MARK: StoryboardSceneBased

extension LaunchesViewController: StoryboardSceneBased {
    static var sceneStoryboard: UIStoryboard {
        UIStoryboard(name: "LaunchesViewController", bundle: nil)
    }
}
