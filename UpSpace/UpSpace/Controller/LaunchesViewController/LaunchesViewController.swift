//
//  NextLaunchesViewController.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 22/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Reusable
import UIKit

final class LaunchesViewController: UITableViewController {
    private var isLaunchesLoaded = false
    private var isScrolled = false // Check is method "scrollViewDidScroll" called
    private var isInitialLoading = true
    private var isAllLaunches = false // Check is all launches download from the server
    private let refreshController: UIRefreshControl = {
        let controller = UIRefreshControl()
        controller.addTarget(self, action: #selector(refreshLaunchesData(_:)), for: .valueChanged)
        return controller
    }()
    private var newIndexPaths: [IndexPath]?
    private var timerUpdating: Timer?
    private var activityIndicatorView = UIActivityIndicatorView(style: .gray)
    var navController: UINavigationController?
    var viewModel: LaunchesViewModelProtocol?
    private var launches = [Launch]() {
        didSet {
            newIndexPaths = stride(from: oldValue.count, to: launches.count, by: 1).map { IndexPath(row: $0, section: 0) }
            isLaunchesLoaded = true
            guard isInitialLoading else { return }
            isInitialLoading.toggle()
            activityIndicatorView.stopAnimating()
            reloadTableView(for: newIndexPaths)
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        }
    }
    
    @objc func refreshLaunchesData(_ sender: Any) {
        launches = []
        isInitialLoading = true
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        viewModel?.update()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = activityIndicatorView
        tableView.refreshControl = refreshController
        tableView.contentInset = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)
        tableView.register(cellType: NextLaunchCell.self)
        tableView.register(headerFooterViewType: LoadingLaunchCell.self)
        viewModel?.onLaunchesChanged = { [weak self] list in
            guard let self = self else { return }
            self.refreshController.endRefreshing()
            guard let list = list else {
                self.isAllLaunches = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.tableView.reloadData()
                }
                return
            }
            self.launches += list.launches
        }
        viewModel?.loadMore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        activityIndicatorView.startAnimating()
    }
}

// MARK: Private

private extension LaunchesViewController {
    private func reloadTableView(for indexPaths: [IndexPath]?) {
        guard let indexPaths = newIndexPaths else { return }
        let position = self.tableView.contentOffset.y
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: indexPaths, with: .fade)
        self.tableView.endUpdates()
        self.tableView.setContentOffset(CGPoint(x: 0, y: position), animated: false)
        isLaunchesLoaded = false
        isScrolled = false
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

extension LaunchesViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launches.count
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(LoadingLaunchCell.self)
        guard !isInitialLoading else {
            footer?.mode = .initial
            return footer
        }
        footer?.mode = isAllLaunches ? .stop : .load
        return footer
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as NextLaunchCell
        let launch = launches[indexPath.row]
        cell.launch = launch
        return cell
    }
}

// MARK: UITableViewDelegate

extension LaunchesViewController {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.size.height - 100 && !isScrolled && !isInitialLoading {
            isScrolled = true
            viewModel?.loadMore()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row < launches.count else { return }
        let controller = InfoLaunchViewController.instantiate()
        controller.launch = launches[indexPath.row]
        navController?.pushViewController(controller, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row >= launches.count ? 50 : 78
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row >= launches.count ? 50 : UITableView.automaticDimension
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard !isInitialLoading && isScrolled else { return }
        guard self.timerUpdating == nil else { return }
        startTimerForUpdate()
    }
}

extension LaunchesViewController: StoryboardSceneBased {
    static var sceneStoryboard: UIStoryboard {
        return UIStoryboard(name: "LaunchesViewController", bundle: nil)
    }
}
