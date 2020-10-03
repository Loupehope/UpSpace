//
//  LaunchList.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 22/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Foundation

struct LaunchList: LaunchListProtocol, Decodable, Equatable {
    var launches: [Launch]

    static func == (lhs: LaunchList, rhs: LaunchList) -> Bool {
        lhs.launches == rhs.launches
    }
}
