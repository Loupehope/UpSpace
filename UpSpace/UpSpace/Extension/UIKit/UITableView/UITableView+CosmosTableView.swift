//
//  UITableView+CosmosTableView.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 04.05.2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

import UIKit

extension UITableView {
    static var cosmosTableView: UITableView {
        let tableView = UITableView()
        tableView.backgroundColor = .tableViewSpace
        tableView.separatorStyle = .none

        return tableView
    }

    func configureCosmosTableView() {
        backgroundColor = .tableViewSpace
        separatorStyle = .none
    }
}
