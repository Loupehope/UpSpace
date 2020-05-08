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
            self?.tableView?.beginUpdates()
            self?.tableView?.reloadSections([index], with: animation)
            self?.tableView?.endUpdates()
        }
        
        perform(action: completion, withAnimation: animation != .none)
    }
    
    func appendSection(_ section: TableSection, with animation: UITableView.RowAnimation) {
        append(section: section)
        let lastSection = sections.count - 1
        
        let completion = { [weak self] in
            self?.tableView?.beginUpdates()
            self?.tableView?.insertSections([lastSection], with: animation)
            self?.tableView?.endUpdates()
        }
        
        perform(action: completion, withAnimation: animation != .none)
    }
    
    func clearTableView() {
        clear().reload()
    }
    
    private func perform(action: () -> Void, withAnimation isAnimating: Bool) {
        if !isAnimating {
            UIView.performWithoutAnimation {
                action()
            }
        } else {
            action()
        }
    }
}
