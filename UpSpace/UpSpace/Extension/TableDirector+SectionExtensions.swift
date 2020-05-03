//
//  TableDirector+ReplaceSections.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 03.05.2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

import TableKit

extension TableDirector {
    func replaceSection(with section: TableSection, at index: Int) {
        remove(sectionAt: index).insert(section: section, atIndex: index).reload()
    }
    
    func clearTableView() {
        clear().append(section: .empty).reload()
    }
}
