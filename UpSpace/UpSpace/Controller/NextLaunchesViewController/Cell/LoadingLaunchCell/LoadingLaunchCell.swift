//
//  LoadingLaunchCell.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 25/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Reusable
import UIKit

final class LoadingLaunchCell: UITableViewCell {
    enum Mode {
        case load, stop
    }
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    
    func update(for mode: Mode) {
        switch mode {
        case .load:
            activityIndicator.startAnimating()
            titleLabel.text = "Loading launches"
        default:
            titleLabel.text = "There are all available launches"
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
        }
    }
}

extension LoadingLaunchCell: NibReusable {
    static var reuseIdentifier: String {
        return "LoadingCell"
    }
}