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
    private var topBar: TMBar = {
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap
        bar.layout.contentMode = .fit
        bar.buttons.customize { button in
            button.font = UIFont.systemFont(ofSize: 17)
            //swiftlint:disable discouraged_object_literal
            button.selectedTintColor = #colorLiteral(red: 1, green: 0.4752948284, blue: 0.2182578146, alpha: 1)
            button.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        bar.indicator.tintColor = #colorLiteral(red: 1, green: 0.4752948284, blue: 0.2182578146, alpha: 1)
        return bar
    }()
    private var controllers = [LaunchesViewController]()
    
    override func viewDidLoad() {
        automaticallyAdjustsChildInsets = false
        super.viewDidLoad()
        controllers.append(nextLaunchesViewController)
        controllers.append(previousLaunchesViewController)
        dataSource = self
        addBar(topBar, dataSource: self, at: .top)
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
