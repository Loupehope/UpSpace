//
//  FavouritesViewController.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 08.05.2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

import UIKit

final class FavouritesViewController: BaseTableViewController<FavouritesViewModel> {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationTitle = "Favourites"
    }
}
