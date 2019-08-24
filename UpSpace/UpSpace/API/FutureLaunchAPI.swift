//
//  FutureLaunchAPI.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 22/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Foundation
import SwiftDate

final class FutureLaunchAPI: LaunchLibraryAPI {
    private var nextDate = ""
    private var previousDate = ""
    private let dateFormatter = DateFormatterAPI()
    override var path: String {
        return "/1.4/launch/"
    }
    override var headers: [String: String] {
        return ["startdate": previousDate, "enddate": nextDate, "limit": "100"]
    }
    
    init(startDate: Date = Date()) {
        super.init()
        self.previousDate = dateFormatter.convert(date: startDate)
        self.nextDate = dateFormatter.convert(date: Date() + 4.months)
    }
    
    func set(nextDate: String) {
        guard let date = dateFormatter.transformComing(dateString: nextDate) else { return }
        self.previousDate = dateFormatter.convert(date: date + 1.days)
        self.nextDate = dateFormatter.convert(date: date + 4.months)
    }
}
