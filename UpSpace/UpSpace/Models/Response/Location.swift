//
//  Location.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 27/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Foundation

struct Location: Decodable {
    let countryCode: String?
    let id: Int?
    let infoURL: String?
    let name: String?
    let pads: [Pad]?
    let wikiURL: String?
    
    static func makeEmptyLocation() -> Location {
        Location(countryCode: .empty,
                 id: 0,
                 infoURL: .empty,
                 name: .empty,
                 pads: [Pad](),
                 wikiURL: .empty)
    }
}
