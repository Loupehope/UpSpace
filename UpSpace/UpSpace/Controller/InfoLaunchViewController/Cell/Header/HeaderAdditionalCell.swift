//
//  HeaderAdditionalCell.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 02/09/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Reusable
import UIKit

final class HeaderAdditionalCell: UITableViewHeaderFooterView {
    private enum Section: Int {
        case time = 1, mission = 2, location = 3, rocket = 4
    }
    @IBOutlet private var backView: UIView! {
        didSet {
            backView.layer.cornerRadius = 10
        }
    }
    @IBOutlet private var titleLabel: UILabel!
    
    private let sectionTitles: [Section: String] = [.time: "Time", .mission: "Mission", .location: "Location", .rocket: "Rocket"]
    var section: Int? {
        didSet {
            guard let section = section else { return }
            guard let type = Section(rawValue: section) else { return }
            titleLabel.text = sectionTitles[type]
        }
    }
}

// MARK: NibReusable

extension HeaderAdditionalCell: NibReusable {
    static var reuseIdentifier: String {
        "HeaderAdditionalCell"
    }
}
