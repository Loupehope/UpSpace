//
//  Lsp.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 01/09/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Foundation

struct Lsp: Decodable {
    let id: Int
    let name: String
    let countryCode: String
    let type: Int
    let wikiURL: String?
    let infoURLs: [String]?
}
