//
//  TodayLaunchesViewModel.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 25/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Foundation

final class TodayLaunchesViewModel: LaunchesViewModelProtocol {
    private let service = TodayLaunchesService(launchAPI: TodayLaunchAPI())
    var onLaunchesChanged: ((LaunchListProtocol?) -> Void)?
    
    func loadMore() {
        service.load { [weak self] list in
            guard let self = self else { return }
            guard let list = list else {
                self.onLaunchesChanged?(nil)
                return
            }
            self.onLaunchesChanged?(list)
        }
    }
}
