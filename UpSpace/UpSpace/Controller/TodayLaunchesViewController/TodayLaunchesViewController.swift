//
//  TodayLaunchesViewController.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 25/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Foundation
import Reusable

final class TodayLaunchesViewController: UIViewController {
    private enum Const {
        static let cellId = "TodayCell"
    }
    private var launches = [Launch]() {
        didSet {
            let indexPaths = stride(from: oldValue.count, to: launches.count, by: 1).map { IndexPath(row: $0, section: 0) }
            tableView.beginUpdates()
            tableView.insertRows(at: indexPaths, with: .fade)
            tableView.endUpdates()
        }
    }
    private let viewModel = TodayLaunchesViewModel()
    @IBOutlet private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.onLaunchesChanged = { [weak self] list in
            guard let self = self else { return }
            guard let list = list else { return }
            self.launches = list.launches
        }
        viewModel.loadMore()
    }
}

extension TodayLaunchesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Const.cellId, for: indexPath)
        let launch = launches[indexPath.row]
        cell.textLabel?.text = launch.name
        cell.detailTextLabel?.text = launch.isostart
        return cell
    }
}
