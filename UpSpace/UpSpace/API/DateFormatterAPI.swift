//
//  DateFormatterAPI.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 22/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Foundation

final class DateFormatterAPI: DateFormatter {
    private static var iSO8601DateWithMillisec: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd'T'HHmmss'Z'"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter
    }
    
    func getDate(from string: String) -> Date? {
        return DateFormatterAPI.iSO8601DateWithMillisec.date(from: string)
    }
    
    func convertToRequest(date: Date) -> String {
        dateFormat = "yyyy-MM-dd"
        return string(from: date)
    }
}

extension DateFormatterAPI {
    static func formatForCell(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = .current
        return formatter.string(from: date)
    }
    
    static func makeiSOString(for date: Date) -> String {
        return DateFormatterAPI.iSO8601DateWithMillisec.string(from: date)
    }
}
