//
//  NavigationController.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 03.05.2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

import UIKit

final class CosmosNavigationController: UINavigationController {
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        
        configureApperance()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    private func configureApperance(with backgroundColor: UIColor = Appearance.backgroundColor) {
        if #available(iOS 13.0, *) {
            let appearence = UINavigationBarAppearance()
            appearence.configureWithTransparentBackground()
            appearence.backgroundColor = backgroundColor
            appearence.backgroundImage = UIImage()
            appearence.largeTitleTextAttributes = largeTitleTextAttributes
            appearence.titleTextAttributes = titleTextAttributes
            
            navigationBar.standardAppearance = appearence
            navigationBar.scrollEdgeAppearance = appearence
            navigationBar.compactAppearance = appearence
        }
        
        if #available(iOS 11.0, *) {
            navigationBar.largeTitleTextAttributes = largeTitleTextAttributes
            navigationBar.prefersLargeTitles = true
        }
        
        navigationBar.barTintColor = Appearance.backgroundColor
        navigationBar.tintColor = .white
        navigationBar.titleTextAttributes = titleTextAttributes
        navigationBar.shadowImage = .init()
        navigationBar.isTranslucent = false
    }
}

private extension CosmosNavigationController {
    enum Appearance {
        static let backgroundColor: UIColor = .darkGraySpace
        static let titleFont: UIFont = .default
        static let largeTitleFont: UIFont = .largeTitleFont
        static let titleColor: UIColor = .white
    }
}

private extension CosmosNavigationController {
    var largeTitleTextAttributes: [NSAttributedString.Key: Any] {
        [
            .font: Appearance.largeTitleFont,
            .foregroundColor: Appearance.titleColor
        ]
    }
    
    var titleTextAttributes: [NSAttributedString.Key: Any] {
        [
            .font: Appearance.titleFont,
            .foregroundColor: Appearance.titleColor
        ]
    }
}
