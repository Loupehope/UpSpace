//
//  NextLaunchesViewController.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 22/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import TableKit
import UIKit

final class LaunchesViewController: BaseTableViewController {
    private lazy var tableDirector = TableDirector(tableView: tableView)
    
    private var launches: [Launch] = []
    private var launchesViewModel: LaunchesViewModelProtocol?
    
    var navController: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.title = "Launches"
        tableView.contentInset = UIEdgeInsets(top: 48, left: 0, bottom: 2, right: 0)
        
        tableDirector.clearTableView()
        launchesViewModel?.loadMore()
    }
}

// MARK: - ConfigurableUI

extension LaunchesViewController: ConfigurableUI {
    func configure(with viewModel: LaunchesViewModelProtocol) {
        launchesViewModel = viewModel
        
        launchesViewModel?.onLaunchesChanged = { [weak self] list in
            self?.updateLaunches(with: list?.launches ?? [])
        }
    }
}

// MARK: - Private

private extension LaunchesViewController {
    func updateLaunches(with list: [Launch]) {
        launches += list
        
        let rows = launches.map {
            TableRow<NextLaunchCell>(item: .init(launch: $0))
                .on(.click) { [weak self] in
                    self?.didSelectRow(for: $0.item.launch)
                }
        }
        
        tableDirector.replaceSection(at: .zero, with: .create(with: rows), and: .fade)
    }
    
    func didSelectRow(for item: Launch?) {
        let controller = InfoLaunchViewController()
        navController?.pushViewController(controller, animated: true)
    }
    
    func refreshLaunches() {
        launches = []
        tableDirector.clearTableView()
        launchesViewModel?.update()
    }
}
