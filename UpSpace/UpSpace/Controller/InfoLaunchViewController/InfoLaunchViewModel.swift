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
        let header = TableRow<InfoLaunchHeaderCell>(item: "Mission")
        guard let mission = launch.missions?.last else {
            return .empty
        }
        let missionRow = TableRow<InfoMissionCell>(item: InfoMissionCellViewModel(mission: mission))
        return .create(with: [header, missionRow])
    }
    
    func createLspSection() -> TableSection {
        let header = TableRow<InfoLaunchHeaderCell>(item: "LSP")
        guard let lsp = launch.lsp else {
            return .empty
        }
        let lspRow = TableRow<InfoLspCell>(item: InfoLspCellViewModel(lsp: lsp))
        return .create(with: [header, lspRow])
    }
    
    func createRocketSection() -> TableSection {
        let header = TableRow<InfoLaunchHeaderCell>(item: "Rocket")
        guard let rocket = launch.rocket else {
            return .empty
        }
        let rocketRow = TableRow<InfoRocketCell>(item: InfoRocketCellViewModel(rocket: rocket))
        return .create(with: [header, rocketRow])
    }
}
