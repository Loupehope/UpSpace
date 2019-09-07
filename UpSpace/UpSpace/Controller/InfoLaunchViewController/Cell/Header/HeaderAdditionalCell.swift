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
        case mission = 1, location = 2, rocket = 3
    }
    @IBOutlet private var backView: UIView! {
        didSet {
            backView.layer.cornerRadius = 10
        }
    }
    @IBOutlet private var titleLabel: UILabel!
    
    private let sectionTitles: [Section: String] = [.mission: "Mission", .location: "Location", .rocket: "Rocket"]
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
        return "HeaderAdditionalCell"
    }
}
