//
//  TodayLaunchAPI.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 25/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Foundation

final class TodayLaunchAPI: LaunchLibraryAPI {
    private let formatter = DateFormatterAPI()
    override var path: String {
        return "/1.4/launch/"
    }
    override var params: [String: String] {
        return ["startdate": formatter.convertToRequest(date: Date()),
                "enddate": formatter.convertToRequest(date: Date()),
                "limit": "1"]
    }
}
