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
        let navigaiton = UINavigationController(rootViewController: launchesViewCointroller)
        navigaiton.navigationBar.topItem?.title = "Launches"
        navigaiton.navigationBar.prefersLargeTitles = true
        navigaiton.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigaiton.navigationBar.shadowImage = UIImage()
        navigaiton.navigationBar.backgroundColor = .white
        add(controller: navigaiton, to: containerView)
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
