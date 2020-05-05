//
//  UIScrollView+Bottom.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 05.05.2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

import UIKit

extension UIScrollView {
    func  isNearBottomEdge(edgeOffset: CGFloat) -> Bool {
        contentOffset.y + frame.size.height + edgeOffset > contentSize.height
    }
}
