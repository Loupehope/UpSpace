//
//  Launch+icons.swift
//  UpSpace
//
//  Created by Andrew on 09/05/2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

import UIKit

extension Launch {
    static func countryIcon(country: String?) -> UIImage? {
        switch country {
        case "USA":
            return .usa
        case "CHI":
            return .china
        case "GUF":
            return .guf
        case "IND":
            return .india
        case "JAP":
            return .japan
        case "KAZ":
            return .kazakhstan
        case "RUS":
            return .russia
        case "UNK":
            return .unk
        case "ZEL":
            return .zeland
        default:
            return nil
        }
    }
}
