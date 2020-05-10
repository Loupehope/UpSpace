//
//  InfoLaunchViewController.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 26/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import TableKit
import UIKit

class InfoLaunchViewController: BaseTableViewController<InfoLaunchViewModel> {
    private lazy var tableDirector = TableDirector(tableView: contentView)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never

        navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save,
                                                              target: self,
                                                              action: nil)]
        configureAppearence()
    }
    
    func configureAppearence() {
        let sections = [
            viewModel.createCountrySection(),
            viewModel.createMainInfoSection(),
            viewModel.createTimerSection(),
            viewModel.createMissionSection(),
            viewModel.createLspSection(),
            viewModel.createRocketSection()
        ]
        
        tableDirector.appendSections(sections)
    }
}
