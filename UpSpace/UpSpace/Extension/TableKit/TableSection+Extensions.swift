//
//  TableDirector+ClearTableView.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 03.05.2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

import TableKit

extension TableSection {
    static var empty: TableSection {
        .create(with: [EmptyRow.zeroHeightRow])
    }
    
    static func create(with rows: [Row]) -> TableSection {
        let section = TableSection(headerView: UIView(frame: .zero),
                                   footerView: UIView(frame: .zero),
                                   rows: rows)
        return section
    }
}
