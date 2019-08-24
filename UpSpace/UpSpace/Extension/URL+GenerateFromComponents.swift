//
//  URL+GenerateFromComponents.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 22/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Foundation

extension URL {
    static func generateURL(scheme: String, host: String, path: String, headers: [String: String]?) -> URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        if let headers = headers {
            components.queryItems = headers.map { URLQueryItem(name: $0, value: $1) }
        }
        return components.url
    }
}
