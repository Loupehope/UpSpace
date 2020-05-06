//
//  UITableView+Bottom.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 05.05.2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

import UIKit

extension UITableView {
    func  isBottom(offset: CGFloat) -> Bool {
        contentOffset.y + frame.size.height + offset > contentSize.height
    }
    
    func isBottomPTRAvailable(offset: CGFloat) -> Bool {
        isBottom(offset: offset) && !(refreshControl?.isRefreshing ?? false)
    }
}
