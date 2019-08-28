//
//  Launch.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 22/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Foundation

struct Launch: Decodable, Equatable {
    static func == (lhs: Launch, rhs: Launch) -> Bool {
        return lhs.id == rhs.id
    }
    
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
    static func makeEmptyLaunch(with date: Date) -> Launch {
        let location = Location(id: 0, countryCode: "")
        let dateString = DateFormatterAPI.makeiSOString(for: date)
        return Launch(id: 0, name: String(), isostart: dateString, location: location)
    }
}
/*
// MARK: - Mission
struct Mission: Decodable {
    let id: Int
    let name, missionDescription: String
    let type: Int
    let wikiURL: String
    let typeName: String
    let agencies: [Lsp]
    let payloads: [JSONAny]
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case missionDescription = "description"
        case type, wikiURL, typeName, agencies, payloads
    }
}

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
struct Lsp: Decodable {
    let id: Int
    let name, abbrev, countryCode: String
    let type: Int
    let infoURL: JSONNull?
    let wikiURL: String
    let changed: String
    let infoURLs: [String]
}

// MARK: - Launch
final class FullLaunch: Launch {
    let status: Int
    let vidURLs: [String]
    let infoURLs: [String]
    let holdreason: String?
    let failreason: String?
    let rocket: Rocket
    let missions: [Mission]
    let lsp: Lsp
}

*/
