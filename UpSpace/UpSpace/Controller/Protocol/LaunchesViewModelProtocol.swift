//
//  LaunchesViewModelProtocol.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 22/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Foundation

protocol LaunchesViewModelProtocol {
    var onLaunchesChanged: ((LaunchListProtocol?) -> Void)? { get set }
    
    func loadMore()
}
