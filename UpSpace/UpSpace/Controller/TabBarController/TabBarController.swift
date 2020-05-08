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
        let viewModel = NextLaunchesViewModel(api: NextLaunchAPI(limit: 1))
        let controller = InfoLaunchViewController(viewModel: viewModel)
        return controller.withNavigationController()
    }()
    
    private lazy var favouritesViewController: CosmosNavigationController = {
        let viewModel = FavouritesViewModel()
        let controller = FavouritesViewController(viewModel: viewModel)
        return controller.withNavigationController()
    }()
    
    private lazy var launchesViewController = LaunchesTabmanViewController().withNavigationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewControllers()
        configureAppearence()
    }
}

// MARK: - Private

private extension TabBarController {
    func configureViewControllers() {
        let items = TabBarItems.items()
        let itemsViewControllers = [nextLaunchViewController, launchesViewController, favouritesViewController]
        
        zip(itemsViewControllers, items).forEach { $0.0.tabBarItem = $0.1 }
        viewControllers = [nextLaunchViewController, launchesViewController, favouritesViewController]
    }
    
    func configureAppearence() {
        tabBar.unselectedItemTintColor = .darkGraySpace
        tabBar.barTintColor = .whiteSpace
        tabBar.tintColor = .redSpace
        tabBar.isTranslucent = false
    }
}

private extension TabBarController {
    enum TabBarItems {
        static func items() -> [UITabBarItem] {
            let titles = ["Next", "Launches", "Favourites"]
            let images: [UIImage] = [.nextItemTabBar, .launchesItemTabBar, .favouritesItemTabBar]
            
            return zip(titles, images).enumerated()
                .map { (tag: Int, item: (title: String, image: UIImage)) in
                    UITabBarItem(title: item.title, image: item.image, tag: tag)
                }
        }
    }
}
