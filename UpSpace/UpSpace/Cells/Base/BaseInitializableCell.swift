//
//  BaseInitializableTableViewCell.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 03.05.2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

import UIKit

class BaseInitializableCell: UITableViewCell, InitializableUI {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initializeUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        initializeUI()
    }
    
    func addUI() {
        // override
    }
    
    func setupUI() {
        // override
    }
    
    func bindUI() {
        // override
    }
    
    func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    func localizeUI() {
        // override
    }
}
