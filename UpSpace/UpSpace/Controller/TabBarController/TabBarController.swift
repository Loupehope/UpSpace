//
//  TabBarController.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 03.05.2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

import UIKit

final class TabBarController: UITabBarController {
    private lazy var nextLaunchViewController: CosmosNavigationController = {
        let controller = InfoLaunchViewController()
        controller.configure(with: NextLaunchesViewModel(api: NextLaunchAPI(limit: 1), mode: .next))
        return controller.withNavigationController()
    }()
    
    private lazy var launchesViewController = LaunchesTabmanViewController().withNavigationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewControllers()
        configureAppearence()
    }
    
    private func configureViewControllers() {
        let items = TabBarItems.items()
        let itemsViewControllers = [nextLaunchViewController, launchesViewController]
        
        zip(itemsViewControllers, items).forEach { $0.0.tabBarItem = $0.1 }
        viewControllers = [nextLaunchViewController, launchesViewController]
    }
    
    private func configureAppearence() {
        tabBar.unselectedItemTintColor = .darkGraySpace
        tabBar.barTintColor = .whiteSpace
        tabBar.tintColor = .redSpace
        tabBar.isTranslucent = false
    }
}

private extension TabBarController {
    enum TabBarItems {
        static func items() -> [UITabBarItem] {
            let attributes: [String: UIImage] = [
                "Next": .nextItemTabBar,
                "Launches": .launchesItemTabBar
            ]
            
            return attributes.enumerated()
                .map { (tag: Int, item: (title: String, image: UIImage)) in
                    UITabBarItem(title: item.title, image: item.image, tag: tag)
                }
        }
    }
}