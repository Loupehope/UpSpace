//
//  UIViewController+ContainerView.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 20.09.2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import SnapKit
import UIKit

extension UIViewController {
    func add(controller: UIViewController, to view: UIView) {
        view.addSubview(controller.view)
        
        controller.view.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
