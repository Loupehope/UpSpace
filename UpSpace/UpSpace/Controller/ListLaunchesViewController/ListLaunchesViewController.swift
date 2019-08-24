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
    private var isInitialLoading = true
    private var newIndexPaths: [IndexPath]?
    private let viewModel = ListLaunchesViewModel()
    private var timerUpdating: Timer?
    private var launches = [Launch]() {
        didSet {
            newIndexPaths = stride(from: oldValue.count, to: launches.count, by: 1).map { IndexPath(row: $0, section: 0) }
            isLaunchesLoaded = true
            guard isInitialLoading else { return }
            isInitialLoading = false
            reload(indexPaths: newIndexPaths)
        }
    }
    @IBOutlet private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        viewModel.onLaunchesChanged = { [weak self] list in
            guard let self = self else { return }
            self.launches += list.launches
        }
        viewModel.loadMore()
    }
    
    private func reload(indexPaths: [IndexPath]?) {
        guard let indexPaths = newIndexPaths else { return }
        var position: CGFloat = 0
        isLaunchesLoaded = false
        position = self.tableView.contentOffset.y
        UIView.animate(withDuration: 0.4) {
            self.view.layoutIfNeeded()
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: indexPaths, with: .fade)
            self.tableView.setContentOffset(CGPoint(x: 0, y: position), animated: false)
            self.tableView.endUpdates()
        }
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
            cell.textLabel?.text = "Launches loading..."
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
        if indexPath.row == launches.count - 1 {
            viewModel.loadMore()
        }
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
       print(#function)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard self.timerUpdating == nil else { return }
        startTimer()
    }
    func startTimer() {
        self.timerUpdating = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            print("Waiting")
            guard self.isLaunchesLoaded else { return }
            self.reload(indexPaths: self.newIndexPaths)
            self.timerUpdating?.invalidate()
            self.timerUpdating = nil
        }
        self.timerUpdating?.fire()
    }
}

// MARK: StoryboardSceneBased

extension ListLaunchesViewController: StoryboardSceneBased {
    static var sceneStoryboard: UIStoryboard {
        return UIStoryboard(name: Const.storyboardName, bundle: nil)
    }
}
