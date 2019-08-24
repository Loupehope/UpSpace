//
//  ListLaunchesService.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 22/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Alamofire
import Foundation

final class ListLaunchesService: NetworkService {
    private let launchAPI = FutureLaunchAPI(startDate: Date())
    private var launchURL: URL? {
        return URL.generateURL(scheme: launchAPI.scheme,
                               host: launchAPI.host,
                               path: launchAPI.path,
                               headers: launchAPI.headers)
    }
    
    func load(_ completionHandler: @escaping (FutureLaunchList?) -> Void) {
        guard let launchURL = launchURL else { fatalError("Incorrect URL") }
        Alamofire.request(launchURL).responseData {
            switch $0.result {
            case let .success(data):
                let result = try? JSONDecoder().decode(FutureLaunchList.self, from: data)
                self.updateLastLaunchDate(result)
                DispatchQueue.main.async {
                    completionHandler(result)
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func updateLastLaunchDate(_ list: FutureLaunchList?) {
        guard let list = list else { return }
        guard let lastLaunch = list.launches.last else { return }
        launchAPI.set(nextDate: lastLaunch.windowstart)
    }
}
