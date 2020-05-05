//
//  UIRefreshControl.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 05.05.2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

import UIKit

extension UIRefreshControl {
    static var `default`: UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        return refreshControl
    }
}
