//
//  Lsp.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 01/09/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Foundation

struct Lsp: Decodable {
    let abbrev: String?
    let changed: String?
    let countryCode: String?
    let id: Int?
    let infoURL: String?
    let infoURLs: [String]?
    let name: String?
    let type: Int?
    let wikiURL: String?
    
    static func makeEmptyLsp() -> Lsp {
        Lsp(abbrev: .empty,
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
