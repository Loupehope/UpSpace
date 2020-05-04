//
//  InfoLaunchViewController.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 26/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import TableKit
import UIKit

class InfoLaunchViewController: BaseTableViewController {
    private lazy var tableDirector = TableDirector(tableView: tableView)
    private var launchViewModel: LaunchesViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
    }
}

extension InfoLaunchViewController: ConfigurableUI {
    func configure(with viewModel: LaunchesViewModelProtocol) {
        launchViewModel = viewModel
    }
}
