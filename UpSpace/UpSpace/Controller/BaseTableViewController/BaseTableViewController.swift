//
//  BaseTableViewController.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 04.05.2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

import UIKit

class BaseTableViewController: UIViewController {
    let tableView: UITableView = .cosmosTableView
    
    override func loadView() {
        view = tableView
    }
}
