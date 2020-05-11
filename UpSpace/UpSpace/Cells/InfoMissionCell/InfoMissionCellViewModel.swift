//
//  InfoMissionCellViewModel.swift
//  UpSpace
//
//  Created by Andrew on 09/05/2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

final class InfoMissionCellViewModel: ViewModel {
    let missionName: String
    let missionDescription: String
    
    init(missionName: String, missionDesc: String) {
        self.missionName = missionName
        self.missionDescription = missionDesc
    }
}
