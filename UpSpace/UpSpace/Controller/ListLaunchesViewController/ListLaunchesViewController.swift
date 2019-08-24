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
    private var isLaunchesLoaded = false
    private var isWillDisplayed = false // Check is method "tableView willDisplay cell" called
    private var isInitialLoading = true
    private var isAllLaunches = false // Check is all launches download from the server
    private var newIndexPaths: [IndexPath]?
    private var timerUpdating: Timer?
    private let viewModel = ListLaunchesViewModel()
    private var launches = [Launch]() {
        didSet {
            newIndexPaths = stride(from: oldValue.count, to: launches.count, by: 1).map { IndexPath(row: $0, section: 0) }
            isLaunchesLoaded = true
            guard isInitialLoading else { return }
            isInitialLoading = false
            reloadTableView(for: newIndexPaths)
        }
    }
    @IBOutlet private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 44, right: 0)
        viewModel.onLaunchesChanged = { [weak self] list in
            guard let self = self else { return }
            guard let list = list else {
                self.isAllLaunches = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.tableView.reloadData()
                }
                return
            }
            self.launches += list.launches
        }
        viewModel.loadMore()
    }
}

// MARK: Private

private extension ListLaunchesViewController {
    private func reloadTableView(for indexPaths: [IndexPath]?) {
        guard let indexPaths = newIndexPaths else { return }
        let position = self.tableView.contentOffset.y
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: indexPaths, with: .fade)
        self.tableView.endUpdates()
        self.tableView.setContentOffset(CGPoint(x: 0, y: position), animated: false)
        isLaunchesLoaded = false
        isWillDisplayed = false
    }
    
    private func startTimerForUpdate() {
        self.timerUpdating = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            guard self.isLaunchesLoaded else { return }
            self.reloadTableView(for: self.newIndexPaths)
            self.timerUpdating?.invalidate()
            self.timerUpdating = nil
        }
        self.timerUpdating?.fire()
    }
}

// MARK: UITableViewDataSource

extension ListLaunchesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launches.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Const.cellId, for: indexPath)
        if indexPath.row >= launches.count {
            cell.textLabel?.text = isAllLaunches ? "These are all available launches for today." : "Launches loading..."
            cell.detailTextLabel?.text = ""
            return cell
        }
        let launch = launches[indexPath.row]
        cell.textLabel?.text = launch.name
        cell.detailTextLabel?.text = launch.windowstart
        return cell
    }
}

// MARK: UITableViewDataSource

extension ListLaunchesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == launches.count - 1 && !isWillDisplayed {
            isWillDisplayed = true
            viewModel.loadMore()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard self.timerUpdating == nil else { return }
        startTimerForUpdate()
    }
}

// MARK: StoryboardSceneBased

extension ListLaunchesViewController: StoryboardSceneBased {
    static var sceneStoryboard: UIStoryboard {
        return UIStoryboard(name: Const.storyboardName, bundle: nil)
    }
}
