//
//  MainLaunchCell.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 02/09/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Reusable
import UIKit

final class MainLaunchCell: UITableViewCell {
    private enum Status: Int {
        case goes = 1, hold, success, failure
    }
    @IBOutlet private var backView: UIView! {
        didSet {
            backView.layer.cornerRadius = 15
        }
    }
    @IBOutlet private var titleLabel: UILabel! {
        didSet {
            titleLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        }
    }
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var statusLabel: UILabel!
    @IBOutlet private var statusImageView: UIImageView!
    //swiftlint:disable discouraged_object_literal
    private let statusImages: [Status: UIImage] = [.goes: #imageLiteral(resourceName: "progress"), .hold: #imageLiteral(resourceName: "hold"), .success: #imageLiteral(resourceName: "success"), .failure: #imageLiteral(resourceName: "failure")]
    private let statusTitles: [Status: String] = [.goes: "Launch is GO", .hold: "Unplanned hold", .success: "Launch was a success", .failure: "Launch failed"]
    var launch: Launch? {
        didSet {
            guard let launch = launch else { return }
            guard let status = Status(rawValue: launch.status) else { return }
            titleLabel.text = launch.name
            dateLabel.text = DateFormatterAPI.formatForCell(date: launch.start)
            statusLabel.text = statusTitles[status]
            statusImageView.image = statusImages[status]
        }
    }
}

// MARK: NibReusable

extension MainLaunchCell: NibReusable {
    static var reuseIdentifier: String {
        "MainLaunchCell"
    }
}
