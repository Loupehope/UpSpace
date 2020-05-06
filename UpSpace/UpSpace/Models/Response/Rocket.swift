//
//  Rocket.swift
//  UpSpace
//
//  Created by Andrew on 06/05/2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

import Foundation

struct Rocket: Decodable {
    let agencies: [Agency]?
    let configuration: String?
    let familyname: String?
    let id: Int?
    let imageSizes: [Int]?
    let imageURL: String?
    let infoURLs: [String]?
    let name: String?
    let wikiURL: String?
    
    static func makeEmptyRocket() -> Rocket {
        Rocket(agencies: [],
               configuration: .empty,
               familyname: .empty,
               id: 0,
               imageSizes: [],
               imageURL: .empty,
               infoURLs: [],
               name: .empty,
               wikiURL: .empty)
    }
}
