//
//  CountryCodes.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 25/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import UIKit

struct CountryCodes {
    // swiftlint:disable discouraged_object_literal
    private let codes = ["CHN": #imageLiteral(resourceName: "china-flag-round-icon-128"),
                         "JPN": #imageLiteral(resourceName: "japan-flag-round-icon-128"),
                         "UNK": #imageLiteral(resourceName: "GUF3x"),
                         "GUF": #imageLiteral(resourceName: "UNK3X"),
                         "KAZ": #imageLiteral(resourceName: "kazakhstan-flag-round-icon-128"),
                         "RUS": #imageLiteral(resourceName: "russia-flag-round-icon-128"),
                         "USA": #imageLiteral(resourceName: "united-states-of-america-flag-round-icon-128"),
                         "IND": #imageLiteral(resourceName: "india-flag-round-icon-128"),
                         "NZL": #imageLiteral(resourceName: "new-zealand-flag-round-icon-128")]
    private let unknown = UIImage()
    
    static func getImage(for code: String) -> UIImage {
        let country = CountryCodes()
        return country.codes[code] ?? country.unknown
    }
}
