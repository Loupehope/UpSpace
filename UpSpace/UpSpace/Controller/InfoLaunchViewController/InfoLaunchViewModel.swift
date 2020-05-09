//
//  InfoLaunchViewModel.swift
//  UpSpace
//
//  Created by Andrew on 06/05/2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

import Foundation
import TableKit

final class InfoLaunchViewModel: BaseTableViewModel {
    let launch: Launch
    
    init(launch: Launch) {
        self.launch = launch
        super.init()
    }
    
    func createCountrySection() -> TableSection {
        guard let image = launch.countryIcon else {
            return .empty
        }
        
        let countryRow = TableRow<CircleImageCell>(item: .init(image: image))
        return .create(with: [countryRow])
    }
    
    func createMainInfoSection() -> TableSection {
        let mainInfoRow = TableRow<InfoMainCell>(item: .init())
        return .create(with: [mainInfoRow])
    }
    
    func createTimerSection() -> TableSection {
        let header = TableRow<InfoLaunchHeaderCell>(item: "Timer")
        let mainInfoRow = TableRow<InfoTimeCell>(item: .empty)
        return .create(with: [header, mainInfoRow])
    }
    
    func createAnotherSection() -> TableSection {
        let header = TableRow<InfoLaunchHeaderCell>(item: "Mission")
        let mainInfoRow = TableRow<InfoTimeCell>(item: .empty)
        return .create(with: [header, mainInfoRow])
    }
}
