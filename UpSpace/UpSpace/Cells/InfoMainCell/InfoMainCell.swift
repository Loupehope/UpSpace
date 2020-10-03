//
//  InfoMainCell.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 02/09/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import SnapKit
import TableKit
import TIUIKitCore
import UIKit

final class InfoMainCell: BaseInitializableCell {
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let separatorView = UIView()
    private let dateLabel = UILabel()
    private let dateImageView = UIImageView()
    private let dateStackView = UIStackView()
    private let statusLabel = UILabel()
    private let statusImageView = UIImageView()
    private let statusStackView = UIStackView()
    
    override func addViews() {
        super.addViews()
        
        dateStackView.addArrangedSubviews(dateImageView, dateLabel)
        statusStackView.addArrangedSubviews(statusImageView, statusLabel)
        containerView.addSubviews(titleLabel, separatorView, dateStackView, statusStackView)

        contentView.addSubview(containerView)
    }
    
    override func configureLayout() {
        super.configureLayout()
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(CGFloat.bigInset)
            make.leading.trailing.equalToSuperview().inset(CGFloat.defaultInset)
        }
        
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(CGFloat.bigInset)
            make.leading.equalToSuperview().inset(CGFloat.defaultInset)
            make.trailing.equalToSuperview()
            make.height.equalTo(CGFloat.defaultSeparatorHeight)
        }
        
        dateStackView.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom).offset(CGFloat.smallInset)
            make.leading.trailing.equalToSuperview().inset(CGFloat.defaultInset)
        }
        
        statusStackView.snp.makeConstraints { make in
            make.top.equalTo(dateStackView.snp.bottom).offset(CGFloat.smallInset)
            make.leading.trailing.equalToSuperview().inset(CGFloat.defaultInset)
            make.bottom.equalToSuperview().inset(CGFloat.smallInset)
        }
        
        dateImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize.iconSize)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        statusImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize.iconSize)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(CGFloat.smallInset)
            make.trailing.leading.equalToSuperview().inset(CGFloat.defaultInset)
        }
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
        [titleLabel, dateLabel, statusLabel].forEach { $0.numberOfLines = .zero }
        
        [dateStackView, statusStackView].forEach {
            $0.spacing = .littleInset
            $0.axis = .horizontal
        }
        
        dateImageView.image = .calendarLaunch
        statusImageView.image = .clockLaunch
        
        separatorView.backgroundColor = .darkGray
        
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = .defaultCornerRadius
    }
}

// MOCK
extension InfoMainCell: ConfigurableCell {
    func configure(with data: String) {
    }
}

private extension CGSize {
    static let iconSize = CGSize(width: 25, height: 25)
}
