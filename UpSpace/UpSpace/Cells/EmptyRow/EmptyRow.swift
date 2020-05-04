//
//  EmptyRow.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 03.05.2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

import TableKit

final class EmptyRow: TableRow<EmptyCell> {}

extension EmptyRow {
    static var defaultHeightRow: EmptyRow {
        .init(item: .defaultHeight)
    }
    
    static var zeroHeightRow: EmptyRow {
        .init(item: .zero)
    }
}
