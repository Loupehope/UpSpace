//
//  UIViewController+Navigation.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 03.05.2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

import UIKit

extension UIViewController {
    func withNavigationController() -> CosmosNavigationController {
        CosmosNavigationController(rootViewController: self)
    }
}
