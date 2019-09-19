//
//  TimeCell.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 19.09.2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Reusable
import UIKit

final class TimeCell: UITableViewCell {
    @IBOutlet private var dayLabel: UILabel!
    @IBOutlet private var secLabel: UILabel!
    @IBOutlet private var minLabel: UILabel!
    @IBOutlet private var hourLabel: UILabel!
    @IBOutlet private var monthLabel: UILabel!
    @IBOutlet private var yearLabel: UILabel!
    private var viewModel: TimeCellViewModel?
    var time: Date? {
        didSet {
            guard let time = time else { return }
            viewModel = TimeCellViewModel(time: time)
            viewModel?.onTimeChanged = { components in
                self.yearLabel.text = components[0]
                self.monthLabel.text = components[1]
                self.dayLabel.text = components[2]
                self.hourLabel.text = components[3]
                self.minLabel.text = components[4]
                self.secLabel.text = components[5]
            }
            viewModel?.startTime()
        }
    }
}

extension TimeCell: NibReusable {
    static var reuseIdentifier: String {
        return "TimeCell"
    }
}
