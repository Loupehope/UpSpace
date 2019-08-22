//
//  DateFormatterAPI.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 22/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Foundation

final class DateFormatterAPI: DateFormatter {
    func transformComing(dateString: String) -> Date? {
        dateFormat = "MMMM dd, yyyy HH:mm:ss"
        let strWithoutUTC = String(dateString[...dateString.index(dateString.endIndex, offsetBy: -5)])
        return date(from: strWithoutUTC)
    }
    
    func convert(date: Date) -> String {
        dateFormat = "yyyy-MM-dd"
        return string(from: date)
    }
}
