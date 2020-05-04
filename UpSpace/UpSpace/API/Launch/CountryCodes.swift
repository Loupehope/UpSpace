//
//  CountryCodes.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 25/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import UIKit

struct CountryCodes {
    private let codes = ["CHN": #imageLiteral(resourceName: "china"),
                         "JPN": #imageLiteral(resourceName: "japan"),
                         "UNK": #imageLiteral(resourceName: "unk"),
                         "GUF": #imageLiteral(resourceName: "guf"),
                         "KAZ": #imageLiteral(resourceName: "kazakhstan"),
                         "RUS": #imageLiteral(resourceName: "russia"),
                         "USA": #imageLiteral(resourceName: "usa"),
                         "IND": #imageLiteral(resourceName: "india"),
                         "NZL": #imageLiteral(resourceName: "zeland")]
    private let unknown = UIImage()
    
    static func getImage(for code: String) -> UIImage {
        let country = CountryCodes()
        return country.codes[code] ?? country.unknown
    }
}
