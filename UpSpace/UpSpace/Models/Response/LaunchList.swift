//
//  LaunchList.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 22/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Foundation

struct LaunchList: Decodable, Equatable {
    let count: Int?
    let launches: [Launch]?
    let offset: Int?
    let total: Int?
    
    init(launches: [Launch]) {
        self.count = 0
        self.offset = 0
        self.total = 0
        self.launches = launches
    }
    
    init() {
        self.count = 0
        self.launches = []
        self.offset = 0
        self.total = 0
    }
    
    static func == (lhs: LaunchList, rhs: LaunchList) -> Bool {
        lhs.launches == rhs.launches
    }
}
