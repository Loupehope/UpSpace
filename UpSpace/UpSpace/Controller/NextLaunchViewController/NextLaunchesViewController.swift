//
//  NextLaunchesViewController.swift
//  UpSpace
//
//  Created by Andrew on 07/05/2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

import UIKit

class NextLaunchesViewController: BaseTableViewController {
    private var nextLaunchViewModel: NextLaunchesViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension NextLaunchesViewController: ConfigurableUI {
    func configure(with viewModel: NextLaunchesViewModel) {
        nextLaunchViewModel = viewModel
    }
}
