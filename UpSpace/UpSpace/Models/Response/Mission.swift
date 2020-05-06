//
//  Mission.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 01/09/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Foundation

struct Mission: Decodable {
    let id: Int?
    let name: String?
    let description: String?
    let launch: Int?
    let type: Int?
    let wikiURL: String?
    let infoURL: String?
    let changed: String?
    let infoURLs: [String]?
    let agencies: [Agency]?
    let typeName: String?
    
    static func makeEmptyMission() -> Mission {
        Mission(id: 0,
                name: .empty,
                description: .empty,
                launch: 0,
                type: 0,
                wikiURL: .empty,
                infoURL: .empty,
                changed: .empty,
                infoURLs: [String](),
                agencies: [Agency](),
                typeName: .empty)
    }
}
