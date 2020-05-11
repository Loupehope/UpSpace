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
        let mainInfoRow = TableRow<InfoMainCell>(item: .init(launch: launch))
        return .create(with: [mainInfoRow])
    }
    
    func createTimerSection() -> TableSection {
        let header = TableRow<InfoLaunchHeaderCell>(item: "Timer")
        let mainInfoRow = TableRow<InfoTimeCell>(item: .empty)
        return .create(with: [header, mainInfoRow])
    }
    
    func createMissionSection() -> TableSection {
        guard let mission = launch.missions?.last,
            let missionName = mission.name,
            let missionDesc = mission.description else {
                return .empty
        }
        let header = TableRow<InfoLaunchHeaderCell>(item: "Mission")
        let missionRow = TableRow<InfoMissionCell>(item: .init(missionName: missionName,
                                                               missionDesc: missionDesc))
        return .create(with: [header, missionRow])
    }
    
    func createLspSection() -> TableSection {
        guard let lsp = launch.lsp, let lspName = lsp.name else {
            return .empty
        }
        let header = TableRow<InfoLaunchHeaderCell>(item: "LSP")
        let lspRow = TableRow<InfoLabelCell>(item: .init(text: lspName))
        return .create(with: [header, lspRow])
    }
    
    func createRocketSection() -> TableSection {
        guard let rocket = launch.rocket, let rocketName = rocket.name else {
            return .empty
        }
        let header = TableRow<InfoLaunchHeaderCell>(item: "Rocket")
        let rocketRow = TableRow<InfoLabelCell>(item: .init(text: rocketName))
        return .create(with: [header, rocketRow])
    }
}
