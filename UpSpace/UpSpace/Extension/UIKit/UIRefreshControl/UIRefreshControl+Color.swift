//
//  UIRefreshControl+Color.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 02.10.2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

import UIKit

extension UIRefreshControl {
    convenience init(color: UIColor) {
        self.init()

        tintColor = color
    }
}
