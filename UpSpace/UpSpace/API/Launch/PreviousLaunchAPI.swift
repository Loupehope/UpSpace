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
    private var nextDate: String = .empty
    private var previousDate: String = .empty
    private var loadAll = true
    private let dateFormatter = DateFormatterAPI()
    override var path: String {
        "/1.4/launch/"
    }
    override var params: [String: String] {
        ["startdate": previousDate, "enddate": nextDate, "limit": "300"]
    }

    init(startDate: Date = Date()) {
        super.init()
        reload(startDate: startDate)
    }

    override func reload(startDate: Date) {
        previousDate = dateFormatter.convertToRequest(date: Date() - 7.months)
        nextDate = dateFormatter.convertToRequest(date: startDate)
        loadAll.toggle()
    }

    override func set(dateString: String) {
        guard let date = dateFormatter.getDate(from: dateString) else {
            return
        }

        defer {
            nextDate = dateFormatter.convertToRequest(date: date - 1.days )
        }

        loadAll = check(date: date)

        guard !loadAll else {
            previousDate = dateFormatter.convertToRequest(date: date - 10.years)
            return
        }

        previousDate = dateFormatter.convertToRequest(date: date - 7.months)
    }
}

// MARK: - private

private extension PreviousLaunchAPI {
    private var borderYear: Int {
        1_998
    }

    // Check is date smaller or equel "2023-01-01" or note
    func check(date: Date) -> Bool {
        let calendar = Calendar.current.component(.year, from: date)
        return calendar <= borderYear
    }
}
