//
//  UIActivityIndicatorView+Extentions.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 02.10.2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

import UIKit

extension UIActivityIndicatorView {
    enum Size {
        case medium
        case large
    }

    struct Appearance {
        let style: Style
        let color: UIColor

        init(size: Size, color: UIColor = .whiteSpace) {
            switch size {
            case .large:
                if #available(iOS 13.0, *) {
                    style = .large
                } else {
                    style = .whiteLarge
                }

            case .medium:
                if #available(iOS 13.0, *) {
                    style = .medium
                } else {
                    style = .white
                }
            }

            self.color = color
        }
    }

    convenience init(appearance: Appearance) {
        self.init(style: appearance.style)

        color = appearance.color
    }
}
