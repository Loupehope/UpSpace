//
//  Launch+icons.swift
//  UpSpace
//
//  Created by Andrew on 09/05/2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

import UIKit

extension Launch {
    var countryIcon: UIImage? {
        switch location?.countryCode {
        case "USA":
            return .usa
        case "CHN":
            return .china
        case "GUF":
            return .guf
        case "IND":
            return .india
        case "JPN":
            return .japan
        case "KAZ":
            return .kazakhstan
        case "RUS":
            return .russia
        case "UNK":
            return .unk
        case "NZL":
            return .zeland
        default:
            return nil
        }
    }
}
