//
//  UIViewController+NavigationTitle.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 08.05.2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

import UIKit

extension UIViewController {
    var navigationTitle: String? {
        get {
            navigationController?.navigationBar.topItem?.title
        }
        
        set {
            navigationController?.navigationBar.topItem?.title = newValue
        }
    }
}
