//
//  PreviousLaunchAPI.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 27/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Foundation
import SwiftDate

final class PreviousLaunchAPI: LaunchLibraryAPI {
    private var nextDate = ""
    private var previousDate = ""
    private var loadAll = false
    private let dateFormatter = DateFormatterAPI()
    override var path: String {
        return "/1.4/launch/"
    }
    override var params: [String: String] {
        return ["startdate": previousDate, "enddate": nextDate, "limit": "200"]
    }
    
    init(startDate: Date = Date() - 1.days) {
        super.init()
        self.previousDate = dateFormatter.convertToRequest(date: Date() - 7.months)
        self.nextDate = dateFormatter.convertToRequest(date: startDate)
    }
    
    override func set(dateString: String) {
        guard let date = dateFormatter.getDate(from: dateString) else { return }
        defer {
            self.nextDate = dateFormatter.convertToRequest(date: date - 1.days )
        }
        loadAll = check(date: date)
        guard !loadAll else {
            self.previousDate = dateFormatter.convertToRequest(date: date - 10.years)
            return }
        self.previousDate = dateFormatter.convertToRequest(date: date - 7.months)
    }
}

// MARK: private

private extension PreviousLaunchAPI {
    private var borderYear: Int {
        return 1_998
    }
    
    // Check is date smaller or equel "2023-01-01" or note
    func check(date: Date) -> Bool {
        let calendar = Calendar.current.component(.year, from: date)
        return calendar <= borderYear
    }
}
