//
//  PreviousLaunchesViewModel.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 27/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Foundation
import SwiftDate

final class PreviousLaunchesViewModel: LaunchesViewModel {
    override func sort(launches: LaunchList) -> LaunchList {
        let launch = previousLaunch != nil ? previousLaunch : Launch.makeEmptyLaunch(with: Date())
        let nextLaunches = launches.launches?.filter { $0.start.timeIntervalSince1970 <= launch?.start.timeIntervalSince1970 ?? 0 }
        let sorted = nextLaunches?.sorted { first, second in
            first.start > second.start
        }
        return LaunchList(launches: sorted ?? [])
    }
}
