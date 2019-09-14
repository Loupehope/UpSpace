//
//  InfoLaunchViewController.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 26/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Reusable
import UIKit

class InfoLaunchViewController: UITableViewController {
    var launch: Launch?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Upcoming"
        navigationItem.largeTitleDisplayMode = .never
        tableView.register(cellType: MainLaunchCell.self)
        tableView.register(headerFooterViewType: HeaderAdditionalCell.self)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section > 0 ? 100 : UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section > 0 ? 29 : 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(for: indexPath) as MainLaunchCell
            cell.launch = launch
            return cell
        default:
            let cell = tableView.dequeueReusableCell(for: indexPath) as MainLaunchCell
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section > 0 else { return nil }
        let header = tableView.dequeueReusableHeaderFooterView(HeaderAdditionalCell.self)
        header?.section = section
        return header
    }
}

// MARK: StoryboardSceneBased

extension InfoLaunchViewController: StoryboardSceneBased {
    static var sceneStoryboard: UIStoryboard {
        return UIStoryboard(name: "InfoLaunchViewController", bundle: nil)
    }
}
