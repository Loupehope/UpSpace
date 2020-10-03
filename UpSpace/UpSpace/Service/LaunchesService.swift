//
//  NextLaunchesService.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 22/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Alamofire
import Foundation

final class LaunchesService: NetworkService {
    private let launchAPI: LaunchLibraryAPI
    private var launchURL: URL? {
        URL.generateURL(scheme: launchAPI.scheme,
                        host: launchAPI.host,
                        path: launchAPI.path,
                        params: launchAPI.params)
    }
    
    init(launchAPI: LaunchLibraryAPI) {
        self.launchAPI = launchAPI
    }
    
    func reload() {
        launchAPI.reload(startDate: Date())
    }
    
    func updateLaunch(dateString: String) {
        launchAPI.set(dateString: dateString)
    }
    
    func load(successCompletion: ((LaunchListProtocol?) -> Void)?, errorCompletion: ((Error) -> Void)?) {
        guard let launchURL = launchURL else { fatalError("Incorrect URL") }
        
        AF.request(launchURL).responseData {
            switch $0.result {
            case let .success(data):
                guard let result = try? JSONDecoder().decode(LaunchList.self, from: data) else {
                    fatalError("Couldn't decode JSON response")
                }
                
                DispatchQueue.main.async {
                    successCompletion?(result)
                }
            case let .failure(error):
                errorCompletion?(error)
            }
        }
    }
}
