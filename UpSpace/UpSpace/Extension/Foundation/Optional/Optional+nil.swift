//
//  Optional+nil.swift
//  UpSpace
//
//  Created by Andrew on 06/05/2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

import Foundation

extension Optional where Wrapped == String {
    var orEmpty: String {
        self ?? .empty
    }
}
