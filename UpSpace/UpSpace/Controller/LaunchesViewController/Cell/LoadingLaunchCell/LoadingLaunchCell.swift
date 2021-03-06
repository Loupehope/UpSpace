//
//  LoadingLaunchCell.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 25/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Reusable
import UIKit

final class LoadingLaunchCell: UITableViewHeaderFooterView {
    enum Mode {
        case load, stop, initial
    }
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.hidesWhenStopped = true
        }
    }
    var mode: Mode? {
        didSet {
            guard let mode = mode else { return }
            switch mode {
            case .initial:
                isHidden = true
            case .load:
                activityIndicator.startAnimating()
            default:
                titleLabel.text = "There are all available launches"
                titleLabel.isHidden = false
                activityIndicator.stopAnimating()
                activityIndicator.isHidden = true
            }
        }
    }
}

// MARK: NibReusable

extension LoadingLaunchCell: NibReusable {
    static var reuseIdentifier: String {
        return "LoadingCell"
    }
}
