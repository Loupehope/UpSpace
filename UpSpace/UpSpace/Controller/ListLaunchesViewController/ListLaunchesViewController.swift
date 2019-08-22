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
    private var launches: LaunchList? {
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
            self.launches = list
        }
        viewModel.loadMore()
    }
}

// MARK: UITableViewDataSource

extension ListLaunchesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launches?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Const.cellId, for: indexPath)
        guard let launches = launches else { return cell }
        let launch = launches.launches[indexPath.row]
        cell.textLabel?.text = launch.name
        cell.detailTextLabel?.text = "\(launch.id)"
        return cell
    }
}

// MARK: StoryboardSceneBased

extension ListLaunchesViewController: StoryboardSceneBased {
    static var sceneStoryboard: UIStoryboard {
        return UIStoryboard(name: Const.storyboardName, bundle: nil)
    }
}
