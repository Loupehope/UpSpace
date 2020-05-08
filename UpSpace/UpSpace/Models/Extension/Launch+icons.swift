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
            print("USA")
            return UIImage.usa
        case "CHI":
            return UIImage.china
        case "GUF":
            return UIImage.guf
        case "IND":
            return UIImage.india
        case "JAP":
            return UIImage.japan
        case "KAZ":
            return UIImage.kazakhstan
        case "RUS":
            return UIImage.russia
        case "UNK":
            return UIImage.unk
        case "ZEL":
            return UIImage.zeland
        default:
            return nil
        }
    }
}
