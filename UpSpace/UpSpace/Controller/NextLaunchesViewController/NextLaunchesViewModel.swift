//
//  NextLaunchesViewModel.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 22/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Foundation

final class NextLaunchesViewModel: LaunchesViewModelProtocol {
    private let launchAPI = NextLaunchAPI()
    private let service: NextLaunchesService
    private var previousLaunch: Launch?
    private var oldList: LaunchListProtocol = FutureLaunchList(launches: [])
    var onLaunchesChanged: ((LaunchListProtocol?) -> Void)?
    
    init() {
        service = NextLaunchesService(launchAPI: launchAPI)
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
}

private extension NextLaunchesViewModel {
private func sort(launches: LaunchListProtocol) -> LaunchListProtocol {
        guard let launch = previousLaunch else {
            previousLaunch = launches.launches.last
            return launches
        }
        let nextLaunches = launches.launches.filter { $0.start.timeIntervalSince1970 >= launch.start.timeIntervalSince1970 }
        let sorted = nextLaunches.sorted { first, second in
            first.start < second.start
        }
        return FutureLaunchList(launches: sorted)
    }
}
