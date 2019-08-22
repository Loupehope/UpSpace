//
//  LaunchAPI.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 22/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Foundation

final class LaunchAPI: LaunchLibraryAPI {
    override var path: String {
        return "/1.4/launch/"
    }
    override var headers: [String: String] {
        return [:]
    }
}
