//
//  LaunchLibraryAPI.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 22/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Foundation

class LaunchLibraryAPI {
    var scheme: String {
        return "https"
    }
    var host: String {
        return "launchlibrary.net"
    }
    var path: String {
        fatalError("This property must be overriden in subclass")
    }
    var params: [String: String] {
        fatalError("This property must be overriden in subclass")
    }
    
    func set(dateString: String) {}
}
