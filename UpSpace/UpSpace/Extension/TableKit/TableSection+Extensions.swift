//
//  TableDirector+ClearTableView.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 03.05.2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

import LeadKit
import TableKit

extension TableSection {
    static var empty: TableSection {
        .init(onlyRows: [EmptyCellRow(height: .zero)])
    }
}
