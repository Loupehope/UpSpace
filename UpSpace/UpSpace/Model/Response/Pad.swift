//
//  Pad.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 28/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Foundation

struct Pad: Decodable {
    let id: Int
    let name: String
    let infoURLs: [String]
    let wikiURL: String
    let latitude: Double
    let longitude: Double
}
