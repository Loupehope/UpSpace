//
//  BaseInitializableTableViewCell.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 03.05.2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

import LeadKit

class BaseInitializableCell: UITableViewCell, InitializableView {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        initializeView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        initializeView()
    }

    func addViews() {
        // override
    }

    func configureLayout() {
        // override
    }

    func bindUI() {
        // override
    }

    func configureAppearance() {
        selectionStyle = .none
        backgroundColor = .clear
    }

    func localizeUI() {
        // override
    }
}
