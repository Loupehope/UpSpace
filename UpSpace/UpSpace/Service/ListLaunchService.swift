//
//  ListLaunchService.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 22/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Alamofire
import Foundation

final class ListLaunchService: NetworkService {
    private var launchURL: URL? {
        let launchAPI = LaunchAPI()
        return URL.generateURL(scheme: launchAPI.scheme,
                               host: launchAPI.host,
                               path: launchAPI.path,
                               headers: nil)
    }
    
    func load(_ completionHandler: @escaping (LaunchList?) -> Void) {
        guard let launchURL = launchURL else { fatalError("Incorrect URL") }
        Alamofire.request(launchURL).responseData {
            switch $0.result {
            case let .success(data):
                let result = try? JSONDecoder().decode(LaunchList.self, from: data)
                DispatchQueue.main.async {
                    completionHandler(result)
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
