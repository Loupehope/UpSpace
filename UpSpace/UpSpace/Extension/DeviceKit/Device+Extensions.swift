//
//  DeviceKit+Extensions.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 06.05.2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

import DeviceKit

extension Device {
    static var isSmallScreen: Bool {
        Device.current.diagonal <= 4
    }
}
