//
//  NextLaunchesViewController.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 22/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import RxSwift
import SnapKit
import TableKit
import UIKit

final class LaunchesViewController: BaseTableViewController<LaunchesViewModel> {
    private let errorPlaceholderView = UpSpacePlaceholderView()
    private let emptyPlaceholderView = UpSpacePlaceholderView()
    
    private lazy var tableDirector = TableDirector(tableView: contentView)
    
    var navController: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.contentInset = .tableViewContentInset
        
        tableDirector.clearTableView()
        
        addRefreshControl()
        addBottomRefreshControl()
        addErrorPlaceholder()
        addEmptyPlaceholder()
        
        bindViewModel()
        
        viewModel.handleRefresh()
    }
    
    private func addErrorPlaceholder() {
        contentView.addSubview(errorPlaceholderView)
    
        errorPlaceholderView.snp.makeConstraints {
            $0.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        errorPlaceholderView.configure(with: .init(title: .loadingErrorTitle,
                                                   buttonTitle: .retry,
                                                   onButtonTapAction: { [weak self] in
                                                    self?.errorPlaceholderView.update(for: .loading)
                                                    self?.viewModel.handleRefresh()
                                                   }))
        errorPlaceholderView.isHidden = true
    }
    
    private func addEmptyPlaceholder() {
        contentView.addSubview(emptyPlaceholderView)
    
        emptyPlaceholderView.snp.makeConstraints {
            $0.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        emptyPlaceholderView.configure(with: .init(title: .emptyLaunchesTitle,
                                                   buttonTitle: .refresh,
                                                   onButtonTapAction: { [weak self] in
                                                    self?.emptyPlaceholderView.update(for: .loading)
                                                    self?.viewModel.handleRefresh()
                                                   }))
        emptyPlaceholderView.isHidden = false
        emptyPlaceholderView.update(for: .loading)
    }
}

// MARK: - Private

private extension LaunchesViewController {
    func updateLaunches(with list: [Launch]) {
        let rows = viewModel.createRows(for: list, with: didSelectRow(for:))
        tableDirector.appendSection(.create(with: rows), with: .fade)
        
        viewModel.didScrollToTop()
        
        contentView.refreshControl?.endRefreshing()
        
        if tableDirector.isEmpty {
            emptyPlaceholderView.isHidden = false
            errorPlaceholderView.isHidden = true
            emptyPlaceholderView.update(for: .normal)
        } else {
            emptyPlaceholderView.isHidden = true
            errorPlaceholderView.isHidden = true
        }
    }
    
    func didSelectRow(for item: Launch?) {
        let viewController = InfoLaunchViewController(viewModel: .init())
        navigationController?.pushViewController(viewController, animated: true)
    }
}

private extension LaunchesViewController {
    func addRefreshControl() {
        let refreshControl = UIRefreshControl(color: .whiteSpace)
        contentView.refreshControl = refreshControl
        
        refreshControl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
    }
    
    @objc func refreshAction() {
        CFRunLoopPerformBlock(CFRunLoopGetMain(), CFRunLoopMode.defaultMode.rawValue) { [weak self] in
            self?.viewModel.handleRefresh()
        }
    }
    
    func addBottomRefreshControl() {
        let activityView: CosmosActivityView = .default
        contentView.tableFooterView = activityView
        bindScrollToBottom(activityView: activityView, for: contentView)
    }
}

private extension LaunchesViewController {
    func bindViewModel() {
        viewModel.onLaunchesLoadObservable
            .observeOn(MainScheduler.asyncInstance)
            .skip(1)
            .subscribe(onNext: { [weak self] in
                self?.updateLaunches(with: $0?.launches ?? [])
            }, onError: { [weak self] _ in
                self?.errorPlaceholderView.isHidden = false
                self?.showError()
            })
            .disposed(by: disposeBag)
    }
    
    func showError() {
        guard !tableDirector.isEmpty else {
            emptyPlaceholderView.isHidden = true
            return
        }
        
        let alertController = UIAlertController(title: .loadingErrorTitle,
                                                message: nil,
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: .ok, style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

private extension UIEdgeInsets {
    static let tableViewContentInset = UIEdgeInsets(top: 48, left: 0, bottom: 2, right: 0)
}
