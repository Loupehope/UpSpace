//
//  CircleImageCellViewModel.swift
//  UpSpace
//
//  Created by Andrew on 07/05/2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

import Foundation

final class CircleImageCellViewModel: ViewModel {
    let image: String?
    
    init(launch: Launch) {
        self.image = "flags/" + (launch.location?.countryCode?.lowercased() ?? .empty)
    }
}
