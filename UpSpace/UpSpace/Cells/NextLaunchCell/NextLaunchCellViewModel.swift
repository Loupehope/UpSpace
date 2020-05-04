//
//  NextLaunchViewModel.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 03.05.2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

import Foundation

final class NextLaunchCellViewModel: ViewModel {
    let launch: Launch
    
    init(launch: Launch) {
        self.launch = launch
    }
}
