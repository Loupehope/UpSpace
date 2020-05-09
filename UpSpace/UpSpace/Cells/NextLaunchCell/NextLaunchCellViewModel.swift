//
//  NextLaunchViewModel.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 03.05.2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

import UIKit

final class NextLaunchCellViewModel: ViewModel {
    let launch: Launch
    
    var launchTitle: String {
        launch.name.orEmpty
    }
    
    var countryIcon: UIImage? {
        launch.countryIcon
    }
    
    var launchDate: String {
        DateFormatterAPI.formatForCell(date: launch.start)
    }
    
    init(launch: Launch) {
        self.launch = launch
    }
}
