//
//  NextLaunchesViewController.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 22/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import LeadKit
import RxSwift
import TableKit
import TIUIElements

final class LaunchesViewController: BaseTableViewController<LaunchesViewModel> {
    private let errorPlaceholderView = UpSpacePlaceholderView()
    private let emptyPlaceholderView = UpSpacePlaceholderView()
    
    var navController: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.contentInset = .tableViewContentInset
        
        tableDirector.safeClear()
        
        addBottomRefreshControl()
        addErrorPlaceholder()
        addEmptyPlaceholder()
        
        bindViewModel()
        
        viewModel.handleRefresh()
    }
    
    private func addErrorPlaceholder() {
        tableView.addSubview(errorPlaceholderView)
    
        errorPlaceholderView.snp.makeConstraints {
            $0.edges.equalTo(tableView.safeAreaLayoutGuide)
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
        tableView.addSubview(emptyPlaceholderView)
    
        emptyPlaceholderView.snp.makeConstraints {
            $0.edges.equalTo(tableView.safeAreaLayoutGuide)
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
        tableDirector.insert(section: .init(onlyRows: rows),
                             at: tableDirector.sections.count,
                             with: .fade)
        
        viewModel.didScrollToTop()
        
        tableView.refreshControl?.endRefreshing()
        
        if tableDirector.isEmpty {
            emptyPlaceholderView.isHidden = false
            errorPlaceholderView.isHidden = true
            emptyPlaceholderView.update(for: .normal)
        } else {
            if tableView.refreshControl == nil {
                addRefreshControl()
            }
            
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
        let refreshControl = RefreshControl(color: .whiteSpace)
        tableView.refreshControl = refreshControl
        
        refreshControl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
    }
    
    @objc func refreshAction() {
        viewModel.handleRefresh()
    }
    
    func addBottomRefreshControl() {
        let activityView: CosmosActivityView = .default
        tableView.tableFooterView = activityView
        bindScrollToBottom(activityView: activityView, for: tableView)
    }
}

private extension LaunchesViewController {
    func bindViewModel() {
        viewModel.onLoadingError = { [weak self] _ in
            self?.tableView.refreshControl?.endRefreshing()
            self?.showError()
        }
        
        viewModel.onLaunchesLoadObservable
            .observeOn(MainScheduler.asyncInstance)
            .skip(1)
            .bind { [weak self] in
                self?.updateLaunches(with: $0?.launches ?? [])
            }
            .disposed(by: disposeBag)
    }
    
    func showError() {
        guard !tableDirector.isEmpty else {
            emptyPlaceholderView.isHidden = true
            errorPlaceholderView.isHidden = false
            errorPlaceholderView.update(for: .normal)
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
