//
//  LaunchesContainerViewController.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 26/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Tabman
import UIKit

final class LaunchesContainerViewController: UIViewController {
    @IBOutlet private var containerView: UIView!
    private let navController: UINavigationController = {
        let launchesViewCointroller = LaunchesTabmanViewController.instantiate()
        let navigation = UINavigationController(rootViewController: launchesViewCointroller)
        navigation.navigationBar.topItem?.title = "Launches"
        navigation.navigationBar.prefersLargeTitles = true
        navigation.navigationBar.isTranslucent = false
        navigation.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigation.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().tintColor = UIColor.white
        //swiftlint:disable discouraged_object_literal
        navigation.navigationBar.barTintColor = #colorLiteral(red: 0.2250607014, green: 0.2795445025, blue: 0.3133514225, alpha: 1)
        navigation.navigationBar.shadowImage = UIImage()
        navigation.navigationBar.setBackgroundImage(UIImage(), for: .default)
        return navigation
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        add(controller: navController, to: containerView)
    }
}
