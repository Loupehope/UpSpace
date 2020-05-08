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
        reloadSections(at: [index], with: animation)
    }
    
    func appendSection(_ section: TableSection, with animation: UITableView.RowAnimation) {
        append(section: section)
        appendSections(at: [sections.count - 1], with: animation)
    }
    
    func clearTableView() {
        clear().reload()
    }
    
    private func appendSections(at indexes: IndexSet, with animation: UITableView.RowAnimation) {
        let completion = { [weak self] in
            self?.tableView?.beginUpdates()
            self?.tableView?.insertSections(indexes, with: animation)
            self?.tableView?.endUpdates()
        }
        
        perform(action: completion, withAnimation: animation != .none)
    }
    
    private func reloadSections(at indexes: IndexSet, with animation: UITableView.RowAnimation) {
        let completion = { [weak self] in
            self?.tableView?.beginUpdates()
            self?.tableView?.reloadSections(indexes, with: animation)
            self?.tableView?.endUpdates()
        }
        
        perform(action: completion, withAnimation: animation != .none)
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
