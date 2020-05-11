//
//  InfoRocketCellViewModel.swift
//  UpSpace
//
//  Created by Andrew on 09/05/2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

final class InfoRocketCellViewModel: ViewModel {
    let rocketName: String
    let rocketFamily: String
    let rocketConfiguration: String
    
    init(rocketName: String, rocketFamily: String, rocketConfig: String) {
        self.rocketName = rocketName
        self.rocketFamily = rocketFamily
        self.rocketConfiguration = rocketConfig
    }
}
