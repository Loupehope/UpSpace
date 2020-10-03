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
    let status: Int
    var isFinished: Bool {
        start.timeIntervalSince1970 < Date().timeIntervalSince1970
    }
    let location: Location
    let missions: [Mission]
    let vidURLs: [String]
    let infoURLs: [String]
    var start: Date {
        guard let result = DateFormatterAPI().getDate(from: isostart) else {
            fatalError("Couldn't convert date from string")
        }
        return result
    }

    static func makeEmptyLaunch(with date: Date) -> Launch {
        let location = Location(id: 0, countryCode: .empty, pads: [])
        let dateString = DateFormatterAPI.makeiSOString(for: date)
        return Launch(id: 0,
                      name: .empty,
                      isostart: dateString,
                      status: 0,
                      location: location,
                      missions: [],
                      vidURLs: [],
                      infoURLs: [])
    }

    static func == (lhs: Launch, rhs: Launch) -> Bool {
        lhs.id == rhs.id
    }
}
/*


struct Rocket: Decodable {
    let id: Int
    let name, configuration, familyname: String
    let agencies: [Lsp]
    let wikiURL: String
    let infoURLs: [String]
    let imageSizes: [Int]
    let imageURL: String
}

// MARK: - Lsp


// MARK: - Launch
final class FullLaunch: Launch {
 
    let holdreason: String?
    let failreason: String?
    let rocket: Rocket
    let missions: [Mission]
    let lsp: Lsp
}

*/
