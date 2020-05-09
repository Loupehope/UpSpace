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
    private var launchViewModel: InfoLaunchViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        // Add action selector here
        navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: nil)]
        configureAppearence()
    }
    
    func configureAppearence() {
        let image = Launch.countryIcon(country: launchViewModel?.launch.location?.countryCode)
        let circleImageSection = TableRow<CircleImageCell>(item: CircleImageCellViewModel(image: image))
        guard image != nil else {
            return
        }
        let section = TableSection(rows: [circleImageSection])
        tableDirector += section
    }
}

extension InfoLaunchViewController: ConfigurableUI {
    func configure(with viewModel: InfoLaunchViewModel) {
        launchViewModel = viewModel
    }
}
