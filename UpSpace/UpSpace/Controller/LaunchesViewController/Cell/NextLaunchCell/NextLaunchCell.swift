//
//  NextLaunchCell.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 25/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Reusable
import UIKit

final class NextLaunchCell: UITableViewCell {
    @IBOutlet private var countryIconImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        countryIconImageView.image = nil
    }
    
    func set(launch: Launch) {
        countryIconImageView.image = CountryCodes.getImage(for: launch.location.countryCode)
        titleLabel.text = launch.name
        dateLabel.text = DateFormatterAPI.formatForCell(date: launch.start)
    }
}

extension NextLaunchCell: NibReusable {
    static var reuseIdentifier: String {
        return "LaunchCell"
    }
}
