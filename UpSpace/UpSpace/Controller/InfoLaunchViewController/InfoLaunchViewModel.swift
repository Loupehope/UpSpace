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
}
