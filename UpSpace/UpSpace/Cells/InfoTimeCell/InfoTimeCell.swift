//
//  InfoTimeCell.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 19.09.2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import SnapKit
import TableKit
import UIKit

final class InfoTimeCell: BaseInitializableCell {
    private let yearLabel = UILabel()
    private let yearTitleLabel = UILabel()
    private let yearStackView = UIStackView()
    
    private let monthLabel = UILabel()
    private let monthTitleLabel = UILabel()
    private let monthStackView = UIStackView()
    
    private let dayLabel = UILabel()
    private let dayTitleLabel = UILabel()
    private let dayStackView = UIStackView()
    
    private let hourLabel = UILabel()
    private let hourTitleLabel = UILabel()
    private let hourStackView = UIStackView()
    
    private let minLabel = UILabel()
    private let minTitleLabel = UILabel()
    private let minStackView = UIStackView()
    
    private let secLabel = UILabel()
    private let secTitleLabel = UILabel()
    private let secStackView = UIStackView()
    
    private let dateStackView = UIStackView()
    private let containerView = UIView()
    
    private let horizontalSeparator = UIView()
    private let yearVerticalSeparator = UIView()
    private let monthVerticalSeparator = UIView()
    private let dayVerticalSeparator = UIView()
    private let hourVerticalSeparator = UIView()
    private let minVerticalSeparator = UIView()
    
    override func addViews() {
        super.addViews()
        
        yearStackView.addArrangedSubviews(yearLabel, yearTitleLabel)
        monthStackView.addArrangedSubviews(monthLabel, monthTitleLabel)
        dayStackView.addArrangedSubviews(dayLabel, dayTitleLabel)
        hourStackView.addArrangedSubviews(hourLabel, hourTitleLabel)
        minStackView.addArrangedSubviews(minLabel, minTitleLabel)
        secStackView.addArrangedSubviews(secLabel, secTitleLabel)
        dateStackView.addArrangedSubviews(yearStackView,
                                          monthStackView,
                                          dayStackView,
                                          hourStackView,
                                          minStackView,
                                          secStackView)
        containerView.addSubviews(dateStackView,
                                  horizontalSeparator,
                                  yearVerticalSeparator,
                                  monthVerticalSeparator,
                                  dayVerticalSeparator,
                                  hourVerticalSeparator,
                                  minVerticalSeparator)
        addSubviews(containerView)
    }
    
    override func configureLayout() {
        super.configureLayout()
        
        dateStackView.snp.remakeConstraints { make in
            make.top.bottom.equalToSuperview().inset(CGFloat.smallInset)
            make.leading.trailing.equalToSuperview()
        }
        
        horizontalSeparator.snp.remakeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.leading.equalToSuperview()
            make.height.equalTo(CGFloat.defaultSeparatorHeight)
        }
        
        yearVerticalSeparator.snp.makeConstraints { make in
            make.leading.equalTo(yearStackView.snp.trailing)
            make.width.equalTo(CGFloat.defaultSeparatorHeight)
            make.height.equalToSuperview()
        }
        
        monthVerticalSeparator.snp.makeConstraints { make in
            make.leading.equalTo(monthStackView.snp.trailing)
            make.width.equalTo(CGFloat.defaultSeparatorHeight)
            make.height.equalToSuperview()
        }
        
        dayVerticalSeparator.snp.makeConstraints { make in
            make.leading.equalTo(dayStackView.snp.trailing)
            make.width.equalTo(CGFloat.defaultSeparatorHeight)
            make.height.equalToSuperview()
        }
        
        hourVerticalSeparator.snp.makeConstraints { make in
            make.leading.equalTo(hourStackView.snp.trailing)
            make.width.equalTo(CGFloat.defaultSeparatorHeight)
            make.height.equalToSuperview()
        }
        
        minVerticalSeparator.snp.makeConstraints { make in
            make.leading.equalTo(minStackView.snp.trailing)
            make.width.equalTo(CGFloat.defaultSeparatorHeight)
            make.height.equalToSuperview()
        }
        
        containerView.snp.remakeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(CGFloat.defaultInset)
            make.top.bottom.equalToSuperview().inset(CGFloat.littleInset)
            make.height.equalTo(72)
        }
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
        [
            yearStackView,
            monthStackView,
            dayStackView,
            hourStackView,
            minStackView,
            secStackView
        ].forEach {
            $0.axis = .vertical
            $0.alignment = .center
        }
        
        [
            horizontalSeparator,
            yearVerticalSeparator,
            monthVerticalSeparator,
            dayVerticalSeparator,
            hourVerticalSeparator,
            minVerticalSeparator
        ].forEach {
            $0.backgroundColor = .lightGray
        }
        
        [
            yearTitleLabel,
            monthTitleLabel,
            dayTitleLabel,
            hourTitleLabel,
            minTitleLabel,
            secTitleLabel
        ].forEach {
            $0.textColor = .darkGray
            $0.textAlignment = .center
            $0.font = .describingFont
        }
        
        dateStackView.axis = .horizontal
        dateStackView.distribution = .fillEqually
        
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = .defaultCornerRadius
        
        secLabel.textColor = .redSpace
    }
    
    override func localizeUI() {
        super.localizeUI()
        
        yearTitleLabel.text = "Year"
        monthTitleLabel.text = "Mon"
        dayTitleLabel.text = "Day"
        hourTitleLabel.text = "Hour"
        minTitleLabel.text = "Min"
        secTitleLabel.text = "Sec"
    }
}

extension InfoTimeCell: ConfigurableCell {
    func configure(with date: String) {
    }
}
