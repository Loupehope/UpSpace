//
//  InfoMissionCellViewModel.swift
//  UpSpace
//
//  Created by Andrew on 09/05/2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

final class InfoMissionCellViewModel: ViewModel {
    let mission: Mission
    
    init(mission: Mission) {
        self.mission = mission
    }
}
