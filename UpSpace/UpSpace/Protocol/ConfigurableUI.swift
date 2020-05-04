//
//  ConfigurableUI.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 03.05.2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

protocol ConfigurableUI {
    associatedtype DataSource
    
    func configure(with _: DataSource)
}
