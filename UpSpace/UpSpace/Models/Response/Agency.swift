//
//  Agency.swift
//  UpSpace
//
//  Created by Andrew on 06/05/2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

import Foundation

struct Agency: Decodable {
    let abbrev: String?
    let changed: String?
    let countryCode: String?
    let id: Int?
    let infoURL: String?
    let infoURLs: [String]?
    let name: String?
    let type: Int?
    let wikiURL: String?
    
    static func makeEmptyAgency() -> Agency {
        Agency(abbrev: .empty,
               changed: .empty,
               countryCode: .empty,
               id: 0,
               infoURL: .empty,
               infoURLs: [String](),
               name: .empty,
               type: 0,
               wikiURL: .empty)
    }
}
