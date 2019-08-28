//
//  CustomActivityIndicator.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 29/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import UIKit

final class CustomActivityIndicator: UIActivityIndicatorView {
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        style = .gray
        // swiftlint:disable discouraged_object_literal
        color = #colorLiteral(red: 1, green: 0.4752948284, blue: 0.2182578146, alpha: 1)
        hidesWhenStopped = true
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
