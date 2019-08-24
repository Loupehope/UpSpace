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
    private var startLaunch: Launch?
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
                guard let temp = try? JSONDecoder().decode(FutureLaunchList.self, from: data) else {
                    fatalError("Couldn't decode JSON response")
                }
                let result = self.sort(launches: temp)
                self.updateLastLaunchDate(result)
                DispatchQueue.main.async {
                    completionHandler(result)
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}

private extension ListLaunchesService {
    private func updateLastLaunchDate(_ list: FutureLaunchList) {
        guard let lastLaunch = list.launches.last else { return }
        startLaunch = lastLaunch
        launchAPI.set(nextDate: startLaunch?.windowstart ?? "")
    }
    
    private func sort(launches: FutureLaunchList) -> FutureLaunchList {
        guard let launch = startLaunch else { return launches }
        let nextLaunches = launches.launches.filter { $0.start >= launch.start }
        let sorted = nextLaunches.sorted { first, second in
            first.start < second.start
        }
        return FutureLaunchList(launches: sorted)
    }
}
