//
//  InitializableView.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 03.05.2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

protocol InitializableUI {
    func addUI()
    
    func setupUI()
    
    func bindUI()
    
    func configureUI()
    
    func localizeUI()
}

extension InitializableUI {
    func initializeUI() {
        addUI()
        setupUI()
        bindUI()
        configureUI()
        localizeUI()
    }
}
