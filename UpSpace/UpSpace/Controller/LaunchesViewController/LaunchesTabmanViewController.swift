//
//  LaunchesTabmanViewController.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 28/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Pageboy
import Tabman
import UIKit

class LaunchesTabmanViewController: TabmanViewController {
    private lazy var nextLaunchesViewController: LaunchesViewController = {
        let controller = LaunchesViewController()
        controller.configure(with: NextLaunchesViewModel(api: NextLaunchAPI(), mode: .next))
        return controller
    }()
    
    private lazy var previousLaunchesViewController: LaunchesViewController = {
        let controller = LaunchesViewController()
        controller.configure(with: PreviousLaunchesViewModel(api: PreviousLaunchAPI(), mode: .previous))
        return controller
    }()
    
    private var controllers: [LaunchesViewController] = []
    
    override func viewDidLoad() {
        automaticallyAdjustsChildInsets = false
        super.viewDidLoad()
        
        nextLaunchesViewController.navController = navigationController
        previousLaunchesViewController.navController = navigationController
        
        configureApperance()
        configureControllers()
    }
    
    private func configureControllers() {
        controllers.append(nextLaunchesViewController)
        controllers.append(previousLaunchesViewController)
        
        dataSource = self
        
        addBar(Bar.default, dataSource: self, at: .top)
    }
    
    private func configureApperance() {
        edgesForExtendedLayout = []
        view.backgroundColor = .darkGraySpace
    }
}

extension LaunchesTabmanViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let title = index > .zero ? "Previous" : "Upcoming"
        return TMBarItem(title: title)
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        controllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        controllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        nil
    }
}

private extension LaunchesTabmanViewController {
    enum Bar {
        static var `default`: TMBar {
            let bar = TMBar.ButtonBar()
            bar.layout.transitionStyle = .snap
            bar.layout.contentMode = .fit
            bar.backgroundColor = .lightGraySpace
            
            bar.buttons.customize { button in
                button.tintColor = .darkGraySpace
                button.selectedTintColor = .redSpace
                button.font = .default
            }
            
            bar.indicator.cornerStyle = .rounded
            bar.indicator.weight = .light
            bar.indicator.tintColor = .red
            
            return bar
        }
    }
}
