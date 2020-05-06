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
    private var mode: Mode
    private var oldList = LaunchList()
    
    internal var previousLaunch: Launch?
    
    var onLaunchesChanged: ((LaunchList?) -> Void)?
    
    init(api: LaunchLibraryAPI, mode: Mode) {
        self.launchAPI = api
        self.mode = mode
        
        service = LaunchesService(launchAPI: launchAPI)
    }
    
    func update() {
        oldList = LaunchList(launches: [])
        previousLaunch = nil
        launchAPI.reload(startDate: Date())
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
            if let launch = self.oldList.launches?.last {
                self.previousLaunch = launch
                self.launchAPI.set(dateString: launch.isostart.orEmpty)
            }
            self.onLaunchesChanged?(self.oldList)
        }
    }
    
    func sort(launches: LaunchList) -> LaunchList {
        fatalError("This function must be overriden in subclass")
    }
}
