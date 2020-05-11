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
        let mainInfoRow = TableRow<InfoMainCell>(item: InfoMainCellViewModel(launch: launch))
        return .create(with: [mainInfoRow])
    }
    
    func createTimerSection() -> TableSection {
        let header = TableRow<InfoLaunchHeaderCell>(item: "Timer")
        let mainInfoRow = TableRow<InfoTimeCell>(item: .empty)
        return .create(with: [header, mainInfoRow])
    }
    
    func createMissionSection() -> TableSection {
        guard let mission = launch.missions?.last else {
            return .empty
        }
        let header = TableRow<InfoLaunchHeaderCell>(item: "Mission")
        let missionRow = TableRow<InfoMissionCell>(item: InfoMissionCellViewModel(
            missionName: mission.name.orEmpty,
            missionDesc: mission.description.orEmpty))
        return .create(with: [header, missionRow])
    }
    
    func createLspSection() -> TableSection {
        guard let lsp = launch.lsp else {
            return .empty
        }
        let header = TableRow<InfoLaunchHeaderCell>(item: "LSP")
        let lspRow = TableRow<InfoLspCell>(item: InfoLspCellViewModel(lspName: lsp.name.orEmpty))
        return .create(with: [header, lspRow])
    }
    
    func createRocketSection() -> TableSection {
        guard let rocket = launch.rocket else {
            return .empty
        }
        let header = TableRow<InfoLaunchHeaderCell>(item: "Rocket")
        let rocketRow = TableRow<InfoRocketCell>(item: InfoRocketCellViewModel(
            rocketName: rocket.name.orEmpty,
            rocketFamily: rocket.familyname.orEmpty,
            rocketConfig: rocket.configuration.orEmpty))
        return .create(with: [header, rocketRow])
    }
}
