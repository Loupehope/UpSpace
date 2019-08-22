//
//  ListLaunchesProtocol.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 22/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Foundation

protocol ListLaunchesProtocol {
    var onLaunchesChanged: ((LaunchList) -> Void)? { get set }
    
    func loadMore()
}
