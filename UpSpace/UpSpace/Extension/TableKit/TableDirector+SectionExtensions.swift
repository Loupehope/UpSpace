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
        
        let completion = { [weak self] in
            switch animation {
            case .none:
                self?.reload()
            default:
                self?.tableView?.beginUpdates()
                self?.tableView?.reloadSections([index], with: animation)
                self?.tableView?.endUpdates()
            }
        }
        
        DispatchQueue.main.async {
            completion()
        }
    }
    
    func clearTableView() {
        clear().append(section: .empty).reload()
    }
}
