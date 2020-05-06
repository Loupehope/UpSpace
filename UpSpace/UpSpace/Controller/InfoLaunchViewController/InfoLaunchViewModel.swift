//
//  InfoLaunchViewModel.swift
//  UpSpace
//
//  Created by Andrew on 06/05/2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

import Foundation

class InfoLaunchViewModel: BaseTableViewModel {
  var launch: Launch?
  
  init(launch: Launch?) {
    super.init()
    self.launch = launch
  }
}
