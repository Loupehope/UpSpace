//
//  LaunchElement.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 22/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Foundation

struct LaunchElement: Decodable {
    let id: Int
    let name: String
    let tbdtime: Int
    let tbddate: Int
}
