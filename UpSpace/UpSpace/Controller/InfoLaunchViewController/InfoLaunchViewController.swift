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
    var launch: Launch? {
        didSet {
            guard let launch = launch else { return }
            title = launch.isFinished ? "Previous" : "Upcoming"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        tableView.register(cellType: MainLaunchCell.self)
        tableView.register(headerFooterViewType: HeaderAdditionalCell.self)
        tableView.register(cellType: TimeCell.self)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let finished = launch?.isFinished else {
            return 0
        }
        return finished ? 4 : 5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let launch = launch else {
            fatalError("Launch doesn't initialised")
        }
        switch indexPath.section {
        case 0:
            return UITableView.automaticDimension
        case 1 where !launch.isFinished:
            return 88
        default:
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section > 0 ? 29 : 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let launch = launch else {
            fatalError("Launch doesn't initialised")
        }
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(for: indexPath) as MainLaunchCell
            cell.launch = launch
            return cell
        case 1 where !launch.isFinished:
            let cell = tableView.dequeueReusableCell(for: indexPath) as TimeCell
            cell.time = launch.start
            return cell
        default:
            let cell = tableView.dequeueReusableCell(for: indexPath) as MainLaunchCell
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section > 0 else { return nil }
        guard let launch = launch else {
            fatalError("Launch doesn't initialised")
        }
        let header = tableView.dequeueReusableHeaderFooterView(HeaderAdditionalCell.self)
        header?.section = launch.isFinished ? section + 1 : section
        return header
    }
}

// MARK: StoryboardSceneBased

extension InfoLaunchViewController: StoryboardSceneBased {
    static var sceneStoryboard: UIStoryboard {
        return UIStoryboard(name: "InfoLaunchViewController", bundle: nil)
    }
}
