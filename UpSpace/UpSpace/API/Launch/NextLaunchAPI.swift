//
//  NextLaunchAPI.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 22/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Foundation
import SwiftDate

final class NextLaunchAPI: LaunchLibraryAPI {
    private var nextDate = ""
    private var previousDate = ""
    private var loadAll = false
    private var limit = 0
    private let dateFormatter = DateFormatterAPI()
    override var path: String {
        "/1.4/launch/"
    }
    override var params: [String: String] {
        guard loadAll else {
            return ["startdate": previousDate, "enddate": nextDate, "limit": "200"]
        }
        return ["startdate": previousDate, "limit": "\(limit)"]
    }
    
    init(startDate: Date = Date() + 1.days, limit: Int = 200) {
        super.init()
        reload(startDate: startDate)
    }
    
    override func reload(startDate: Date) {
        self.previousDate = dateFormatter.convertToRequest(date: startDate)
        self.nextDate = dateFormatter.convertToRequest(date: Date() + 7.months)
        loadAll = false
    }
    
    override func set(dateString: String) {
        guard let date = dateFormatter.getDate(from: dateString) else { return }
        defer {
            self.previousDate = dateFormatter.convertToRequest(date: date + 1.days)
        }
        loadAll = check(date: date)
        guard !loadAll else { return }
        self.nextDate = dateFormatter.convertToRequest(date: date + 7.months)
    }
}

// MARK: private

private extension NextLaunchAPI {
    private var borderYear: Int {
        2_023
    }
    
    // Check is date bigger or equel "2023-01-01" or note
    func check(date: Date) -> Bool {
        let calendar = Calendar.current.component(.year, from: date)
        return calendar >= borderYear
    }
}
