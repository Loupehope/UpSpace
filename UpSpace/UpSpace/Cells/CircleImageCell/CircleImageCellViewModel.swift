//
//  CircleImageCellViewModel.swift
//  UpSpace
//
//  Created by Andrew on 07/05/2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

import UIKit

final class CircleImageCellViewModel: ViewModel {
    let image: UIImage?
    
    init(image: UIImage?) {
        self.image = image
    }
}
