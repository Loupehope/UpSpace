//
//  InfoRocketCellViewModel.swift
//  UpSpace
//
//  Created by Andrew on 09/05/2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

final class InfoRocketCellViewModel: ViewModel {
    let rocket: Rocket
    
    init(rocket: Rocket) {
        self.rocket = rocket
    }
}
