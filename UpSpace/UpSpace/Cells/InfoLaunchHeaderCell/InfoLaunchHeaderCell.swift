//
//  InfoLaunchHeaderCell.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 02/09/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import LeadKit
import TableKit

final class InfoLaunchHeaderCell: BaseInitializableCell {
    private let containerView = UIView()
    private let titleLabel = UILabel()

    override func addViews() {
        super.addViews()

        containerView.addSubview(titleLabel)
        contentView.addSubview(containerView)
    }

    override func configureLayout() {
        super.configureLayout()

        titleLabel.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(CGFloat.smallInset)
            make.top.bottom.equalToSuperview().inset(CGFloat.littleInset)
        }

        containerView.snp.remakeConstraints { make in
            make.top.bottom.equalToSuperview().inset(CGFloat.littleInset)
            make.leading.equalToSuperview().offset(CGFloat.defaultInset)
        }
    }

    override func configureAppearance() {
        super.configureAppearance()

        titleLabel.font = .describingFont
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center

        containerView.layer.cornerRadius = .defaultCornerRadius
        containerView.backgroundColor = .redSpace
    }
}

extension InfoLaunchHeaderCell: ConfigurableCell {
    func configure(with title: String) {
        titleLabel.text = title
    }
}
