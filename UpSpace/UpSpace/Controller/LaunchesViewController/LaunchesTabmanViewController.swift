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
        controller.viewModel = NextLaunchesViewModel(api: NextLaunchAPI(), mode: .next)
        return controller
    }()
    
    private var previousLaunchesViewController: LaunchesViewController = {
        let controller = LaunchesViewController.instantiate()
        controller.viewModel = PreviousLaunchesViewModel(api: PreviousLaunchAPI(), mode: .previous)
        return controller
    }()
    
    private var topBar: TMBar = {
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap
        bar.layout.contentMode = .fit
        bar.layer.cornerRadius = 10
        //swiftlint:disable discouraged_object_literal
        bar.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        bar.buttons.customize { button in
            button.tintColor = #colorLiteral(red: 0.2250607014, green: 0.2795445025, blue: 0.3133514225, alpha: 1)
            button.selectedTintColor = #colorLiteral(red: 0.842899859, green: 0.1364972591, blue: 0.1388344765, alpha: 1)
            button.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        }
        bar.indicator.cornerStyle = .rounded
        bar.indicator.weight = .light
        bar.indicator.tintColor = #colorLiteral(red: 0.842899859, green: 0.1364972591, blue: 0.1388344765, alpha: 1)
        return bar
    }()
    
    private var controllers = [LaunchesViewController]()
    
    override func viewDidLoad() {
        automaticallyAdjustsChildInsets = false
        super.viewDidLoad()
        
        edgesForExtendedLayout = []
        nextLaunchesViewController.navController = navigationController
        previousLaunchesViewController.navController = navigationController
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
        controllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        controllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        nil
    }
}

// MARK: StoryboardSceneBased

extension LaunchesTabmanViewController: StoryboardSceneBased {
    static var sceneStoryboard: UIStoryboard {
        UIStoryboard(name: "LaunchesTabmanViewController", bundle: nil)
    }
}
