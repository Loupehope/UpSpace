//
//  BaseTableViewController.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 04.05.2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

import LeadKit
import RxCocoa
import RxSwift
import TableKit

class BaseTableViewController<ViewModelT: BaseTableViewModel>: BaseTableContentController<ViewModelT>, UIScrollViewDelegate {
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        initialLoadView()
    }

    override func createTableDirector() -> TableDirector {
        TableDirector(tableView: tableView, scrollDelegate: self)
    }

    override func configureAppearance() {
        super.configureAppearance()

        tableView.configureCosmosTableView()
    }
}

extension BaseTableViewController {
    func bindScrollToBottom(activityView: CosmosActivityView,
                            for tableView: UITableView,
                            with edgeOffset: CGFloat = -.defaultHeight) {
        viewModel.isBottomObservable
            .observeOn(MainScheduler.asyncInstance)
            .do(onNext: { [weak tableView] in
                tableView?.tableFooterView = $0 ? activityView : UIView(frame: .zero)
            })
            .bind(to: activityView.rx.isAnimating)
            .disposed(by: disposeBag)

        viewModel.bind(loadMoreRequestObservable: activityView.isAnimatingObservable)
            .disposed(by: disposeBag)

        tableView.rx
            .willDisplayCell
            .map { [weak tableView] in
                guard let tableView = tableView else {
                    return false
                }

                let lastSection = tableView.numberOfSections - 1
                let lastCell = tableView.numberOfRows(inSection: lastSection) - 1
                let intexPath = IndexPath(row: lastCell, section: lastSection)

                return $0.indexPath == intexPath && !activityView.isAnimating
            }
            .filter { $0 }
            .bind(to: bottomBinder)
            .disposed(by: disposeBag)
    }
}

private extension BaseTableViewController {
    var bottomBinder: Binder<Bool> {
        Binder(self) { base, _ in
            base.viewModel.didScrollToBottom()
        }
    }
}
