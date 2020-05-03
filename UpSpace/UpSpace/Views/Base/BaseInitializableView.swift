//
//  InitializableView.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 03.05.2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

import UIKit

class BaseInitializableView: UIView, InitializableUI {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
        // override
    }
    
    func localizeUI() {
        // override
    }
}
