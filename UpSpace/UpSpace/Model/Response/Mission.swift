//
//  Mission.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 01/09/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Foundation

struct Mission: Decodable {
    let id: Int
    let name: String
    let description: String
    let type: Int
    let wikiURL: String?
    let typeName: String
    let agencies: [Lsp]?
}
