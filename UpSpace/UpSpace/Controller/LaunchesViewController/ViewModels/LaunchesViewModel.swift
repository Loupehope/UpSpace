//
//  LaunchesViewModel.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 04/09/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Foundation

class LaunchesViewModel: LaunchesViewModelProtocol {
    enum Mode {
        case next, previous
    }
    private let launchAPI: LaunchLibraryAPI
    private let service: LaunchesService
    internal var previousLaunch: Launch?
    private var mode: Mode
    private var oldList: LaunchListProtocol = LaunchList(launches: [])
    var onLaunchesChanged: ((LaunchListProtocol?) -> Void)?
    
    init(api: LaunchLibraryAPI, mode: Mode) {
        self.launchAPI = api
        self.mode = mode
        service = LaunchesService(launchAPI: launchAPI)
    }
    
    func update() {
        let startDate = mode == .next ? Date() : Date() + 1
        oldList = LaunchList(launches: [])
        previousLaunch = nil
        launchAPI.reload(startDate: startDate)
        loadMore()
    }
    
    func loadMore() {
        service.load { [weak self] list in
            guard let self = self else { return }
            guard let list = list else { return }
            guard self.oldList.launches != list.launches else {
                self.onLaunchesChanged?(nil)
                return
            }
            self.oldList = self.sort(launches: list)
            if let launch = self.oldList.launches.last {
                self.previousLaunch = launch
                self.launchAPI.set(dateString: launch.isostart)
            }
            self.onLaunchesChanged?(self.oldList)
        }
    }
    
    //swiftlint:disable unavailable_function
    func sort(launches: LaunchListProtocol) -> LaunchListProtocol {
        fatalError("This func must be overriden in subclass")
    }
}
