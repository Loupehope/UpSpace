//
//  LaunchesViewModel.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 04/09/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import TableKit

class LaunchesViewModel: BaseTableViewModel {
    private let disposeBag = DisposeBag()
    private let onLaunchesLoadRelay = BehaviorRelay<LaunchList?>(value: nil)
    private let service: LaunchesService
    
    private var oldList = LaunchList()
    
    var previousLaunch: Launch?
    
    var onLaunchesLoadObservable: Observable<LaunchList?> {
        onLaunchesLoadRelay.asObservable()
    }
    
    init(api: LaunchLibraryAPI) {
        service = LaunchesService(launchAPI: api)
    }
    
    override func handleRefresh() {
        update()
    }
    
    override func handleLoadMore() {
        loadMore()
    }
    
    func createRows(for launches: [Launch], with clickHandler: ((Launch) -> Void)?) -> [Row] {
        launches.map {
            TableRow<NextLaunchCell>(item: .init(launch: $0))
                .on(.click) { clickHandler?($0.item.launch) }
        }
    }
    
    func sort(launches: LaunchList) -> LaunchList {
        fatalError("This function must be overriden in subclass")
    }
}

private extension LaunchesViewModel {
    func update() {
        oldList = LaunchList(launches: [])
        previousLaunch = nil
        service.reload()
        loadMore()
    }
    
    func loadMore() {
        service.load { [weak self] list in
            guard let self = self, let list = list else {
                return
            }
            
            guard self.oldList.launches != list.launches else {
                self.onLaunchesLoadRelay.accept(nil)
                return
            }
            
            self.oldList = self.sort(launches: list)
            
            if let launch = self.oldList.launches?.last, let isostart = launch.isostart {
                self.previousLaunch = launch
                self.service.updateLaunch(dateString: isostart)
            }
            
            self.onLaunchesLoadRelay.accept(self.oldList)
        }
    }
}
