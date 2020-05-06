//
//  NextLaunchesViewModel.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 22/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Foundation

final class NextLaunchesViewModel: LaunchesViewModel {
    override func sort(launches: LaunchList) -> LaunchList {
        guard let launch = previousLaunch else {
            previousLaunch = launches.launches?.last
            return launches
        }
        let nextLaunches = launches.launches?.filter { $0.start.timeIntervalSince1970 > launch.start.timeIntervalSince1970 }
        let sorted = nextLaunches?.sorted { first, second in
            first.start < second.start
        }
        return LaunchList(launches: sorted ?? [])
    }
}
