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
        // Add action selector here
        navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: nil)]
        configureAppearence()
    }
    
    func configureAppearence() {
        let image = Launch.countryIcon(country: viewModel.launch.location?.countryCode)
        let circleImageSection = TableRow<CircleImageCell>(item: CircleImageCellViewModel(image: image))
        guard image != nil else {
            return
        }
        let section = TableSection(rows: [circleImageSection])
        tableDirector += section
    }
}
