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
    private let launchesViewCointroller = LaunchesTabmanViewController.instantiate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let navigation = UINavigationController(rootViewController: launchesViewCointroller)
        navigation.navigationBar.topItem?.title = "Launches"
        navigation.navigationBar.prefersLargeTitles = true
        navigation.navigationBar.isTranslucent = false
        navigation.navigationBar.tintColor = .white
        navigation.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigation.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().tintColor = UIColor.white
        //swiftlint:disable discouraged_object_literal
        navigation.navigationBar.barTintColor = #colorLiteral(red: 0.2250607014, green: 0.2795445025, blue: 0.3133514225, alpha: 1)
        navigation.navigationBar.shadowImage = UIImage()
        add(controller: navigation, to: containerView)
    }
}

private extension LaunchesContainerViewController {
    func add(controller: UIViewController, to view: UIView) {
        containerView.addSubview(controller.view)
        constraintViewEqual(view1: view, view2: controller.view)
    }
    
    // swiftlint:disable line_length
    private func constraintViewEqual(view1: UIView, view2: UIView) {
        view2.translatesAutoresizingMaskIntoConstraints = false
        let constraint1 = NSLayoutConstraint(item: view1, attribute: .top, relatedBy: .equal, toItem: view2, attribute: .top, multiplier: 1.0, constant: 0.0)
        let constraint2 = NSLayoutConstraint(item: view1, attribute: .trailing, relatedBy: .equal, toItem: view2, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let constraint3 = NSLayoutConstraint(item: view1, attribute: .bottom, relatedBy: .equal, toItem: view2, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let constraint4 = NSLayoutConstraint(item: view1, attribute: .leading, relatedBy: .equal, toItem: view2, attribute: .leading, multiplier: 1.0, constant: 0.0)
        view1.addConstraints([constraint1, constraint2, constraint3, constraint4])
    }
}
