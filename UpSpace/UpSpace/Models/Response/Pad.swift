//
//  Pad.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 28/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Foundation

struct Pad: Decodable {
    let agencies: [Agency]?
    let id: Int?
    let infoURL: String?
    let latitude: Float?
    let longitude: Float?
    let mapURL: String?
    let name: String?
    let wikiURL: String?
    
    static func makeEmptyPad() -> Pad {
        Pad(agencies: [],
            id: 0,
            infoURL: .empty,
            latitude: 0.0,
            longitude: 0.0,
            mapURL: .empty,
            name: .empty,
            wikiURL: .empty)
    }
}
