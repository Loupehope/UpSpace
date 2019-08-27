//
//  Launch.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 22/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Foundation

struct Launch: Decodable, Equatable {
    let id: Int
    let name: String
    let isostart: String
    let location: Location
    var start: Date {
        guard let result = DateFormatterAPI().getDate(from: isostart) else {
            fatalError("Couldn't convert date from string")
        }
        return result
    }
    
    static func == (lhs: Launch, rhs: Launch) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Launch {
    static func makeEmptyLaunch(with date: Date) -> Launch {
        let location = Location(id: 0, countryCode: String())
        let dateString = DateFormatterAPI.makeiSOString(for: date)
        return Launch(id: 0, name: String(), isostart: dateString, location: location)
    }
}
