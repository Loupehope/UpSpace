//
//  BaseViewController.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 05.05.2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

import UIKit

class BaseViewController<ViewModelT: ViewModel, ViewT: UIView>: UIViewController {
    let contentView = ViewT()
    let viewModel: ViewModelT
    
    init(viewModel: ViewModelT) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }
}
