//
//  ListLaunchesViewModel.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 22/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Foundation

final class ListLaunchesViewModel: ListLaunchesProtocol {
    private let service = ListLaunchesService()
    private var oldList = FutureLaunchList(launches: [])
    var onLaunchesChanged: ((FutureLaunchList?) -> Void)?
    
    func loadMore() {
        service.load { [weak self] list in
            guard let self = self else { return }
            guard let list = list else { return }
            guard self.oldList.launches != list.launches else {
                self.onLaunchesChanged?(nil)
                return
            }
            self.oldList = list
            self.onLaunchesChanged?(list)
        }
    }
}
