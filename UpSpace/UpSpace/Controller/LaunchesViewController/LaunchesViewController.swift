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
    private var launches: [Launch] = []
    
    var navController: UINavigationController?
    var viewModel: LaunchesViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 48, left: 0, bottom: 2, right: 0)
        
        viewModel?.onLaunchesChanged = { [weak self] list in
            self?.updateLaunches(with: list?.launches ?? [])
        }

        tableDirector.clearTableView()
        viewModel?.loadMore()
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
    
    func refreshLaunches() {
        launches = []
        tableDirector.clearTableView()
        viewModel?.update()
    }
}

// MARK: StoryboardSceneBased

extension LaunchesViewController: StoryboardSceneBased {
    static var sceneStoryboard: UIStoryboard {
        UIStoryboard(name: "LaunchesViewController", bundle: nil)
    }
}
