//
//  TodayContainerViewController.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 20.09.2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import UIKit

final class TodayContainerViewController: UIViewController {
    @IBOutlet private var containerView: UIView!
    private let viewModel = NextLaunchesViewModel(api: NextLaunchAPI(limit: 1), mode: .next)
    private let infoLaunchViewController = InfoLaunchViewController.instantiate()
    private var launch: Launch? {
        didSet {
            infoLaunchViewController.launch = launch
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.onLaunchesChanged = { launches in
            guard let launches = launches else { return }
            guard let result = launches.launches.first else { return }
            self.launch = result
        }
        add(controller: infoLaunchViewController, to: containerView)
        viewModel.loadMore()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return navigationController?.preferredStatusBarStyle ?? .default
    }
}
