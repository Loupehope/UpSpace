//
//  LaunchesTabmanViewController.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 28/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Pageboy
import Reusable
import Tabman
import UIKit

class LaunchesTabmanViewController: TabmanViewController {
    private var nextLaunchesViewController: LaunchesViewController = {
        let controller = LaunchesViewController.instantiate()
        controller.viewModel = NextLaunchesViewModel()
        return controller
    }()
    private var previousLaunchesViewController: LaunchesViewController = {
        let controller = LaunchesViewController.instantiate()
        controller.viewModel = PreviousLaunchesViewModel()
        return controller
    }()
    private var controllers = [LaunchesViewController]()
    
    override func viewDidLoad() {
        automaticallyAdjustsChildInsets = false
        super.viewDidLoad()
        controllers.append(nextLaunchesViewController)
        controllers.append(previousLaunchesViewController)
        
        self.dataSource = self
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .progressive // Customize
        bar.layout.contentMode = .fit
        bar.buttons.customize { button in
            button.font = UIFont.systemFont(ofSize: 17)
        }
        // Add to view
        addBar(bar, dataSource: self, at: .top)
    }
}

extension LaunchesTabmanViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let title = index > 0 ? "Previous" : "Upcoming"
        return TMBarItem(title: title)
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return controllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return controllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}

// MARK: StoryboardSceneBased

extension LaunchesTabmanViewController: StoryboardSceneBased {
    static var sceneStoryboard: UIStoryboard {
        return UIStoryboard(name: "LaunchesTabmanViewController", bundle: nil)
    }
}
