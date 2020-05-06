//
//  Launch.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 22/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Foundation

struct Launch: Decodable, Equatable {
    let changed: String?
    let failreason: String?
    let hashtag: String?
    let holdreason: String?
    let id: Int?
    let infoURL: String?
    let infoURLs: [String]?
    let inhold: Int?
    let isoend: String?
    let isonet: String?
    let isostart: String?
    let location: Location?
    let lsp: Lsp?
    let missions: [Mission]?
    let name: String?
    let net: String?
    let netstamp: Int?
    let probability: Int?
    let rocket: Rocket?
    let status: Int?
    let tbddate: Int?
    let tbdtime: Int?
    let vidURL: String?
    let vidURLs: [String]?
    let westamp: Int?
    let windowend: String?
    let windowstart: String?
    let wsstamp: Int?
    
    var isFinished: Bool {
        start.timeIntervalSince1970 < Date().timeIntervalSince1970
    }
    
    var start: Date {
        guard let result = DateFormatterAPI().getDate(from: isostart ?? "") else {
            fatalError("Couldn't convert date from string")
        }
        return result
    }
    
    static func == (lhs: Launch, rhs: Launch) -> Bool {
        lhs.id == rhs.id
    }
    
    static func makeEmptyLaunch(with date: Date) -> Launch {
        let location = Location.makeEmptyLocation()
        let dateString = DateFormatterAPI.makeiSOString(for: date)
        return Launch(changed: .empty,
                      failreason: .empty,
                      hashtag: .empty,
                      holdreason: .empty,
                      id: 0,
                      infoURL: .empty,
                      infoURLs: [],
                      inhold: 0,
                      isoend: .empty,
                      isonet: .empty,
                      isostart: dateString,
                      location: location,
                      lsp: Lsp.makeEmptyLsp(),
                      missions: [],
                      name: .empty,
                      net: .empty,
                      netstamp: 0,
                      probability: 0,
                      rocket: Rocket.makeEmptyRocket(),
                      status: 0,
                      tbddate: 0,
                      tbdtime: 0,
                      vidURL: .empty,
                      vidURLs: [],
                      westamp: 0,
                      windowend: .empty,
                      windowstart: .empty,
                      wsstamp: 0)
    }
}
