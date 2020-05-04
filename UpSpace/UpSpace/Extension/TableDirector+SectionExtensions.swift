//
//  TableDirector+ReplaceSections.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 03.05.2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

import TableKit

extension TableDirector {
    func replaceSection(at index: Int, with section: TableSection, and animation: UITableView.RowAnimation) {
        replaceSection(at: index, with: section)
        
        switch animation {
        case .none:
            reload()
        default:
            tableView?.beginUpdates()
            tableView?.reloadSections([index], with: animation)
            tableView?.endUpdates()
        }
    }
    
    func clearTableView() {
        clear().append(section: .empty).reload()
    }
}
