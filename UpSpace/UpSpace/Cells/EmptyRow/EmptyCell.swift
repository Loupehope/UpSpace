//
//  EmptyCell.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 03.05.2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

import TableKit

final class EmptyCell: BaseInitializableCell, ConfigurableCell {
    func configure(with height: CGFloat) {
        snp.makeConstraints { make in
            make.height.equalTo(height)
        }
    }
}
