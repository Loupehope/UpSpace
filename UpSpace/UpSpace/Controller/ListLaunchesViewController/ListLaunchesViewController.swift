//
//  ListLaunchesViewController.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 22/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Reusable
import UIKit

final class ListLaunchesViewController: UIViewController {
    private enum Const {
        static let storyboardName = "ListLaunches"
        static let cellId = "LaunchCell"
    }
    private let viewModel = ListLaunchesViewModel()
    private var launches = [Launch]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    @IBOutlet private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.onLaunchesChanged = { [weak self] list in
            guard let self = self else { return }
            self.launches += list.launches
        }
        viewModel.loadMore()
    }
}

// MARK: UITableViewDataSource

extension ListLaunchesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Const.cellId, for: indexPath)
        let launch = launches[indexPath.row]
        cell.textLabel?.text = launch.name
        cell.detailTextLabel?.text = launch.windowstart
        return cell
    }
}

// MARK: UITableViewDelegate

extension ListLaunchesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (launches.count - 1) {
            viewModel.loadMore()
        }
    }
}

// MARK: StoryboardSceneBased

extension ListLaunchesViewController: StoryboardSceneBased {
    static var sceneStoryboard: UIStoryboard {
        return UIStoryboard(name: Const.storyboardName, bundle: nil)
    }
}
