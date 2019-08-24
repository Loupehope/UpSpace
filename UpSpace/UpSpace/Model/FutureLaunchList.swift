//
//  FutureLaunchList.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 22/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Foundation

struct FutureLaunchList: Decodable, Equatable {
    static func == (lhs: FutureLaunchList, rhs: FutureLaunchList) -> Bool {
        guard lhs.launches.count == rhs.launches.count else { return true }
        for index in 0..<lhs.launches.count {
            guard lhs.launches[index] != rhs.launches[index] else { return false }
            print(#function)
        }
        return true
    }
    
    let launches: [Launch]
}
