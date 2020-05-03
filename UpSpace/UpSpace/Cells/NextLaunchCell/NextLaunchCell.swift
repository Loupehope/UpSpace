//
//  NextLaunchView.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 03.05.2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

import TableKit
import UIKit

final class NextLaunchCell: BaseInitializableCell {
    private let containerView = UIView()
    private let countryIconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    private let textInfoStackView = UIStackView()
    private let goIconImageView = UIImageView()
    
    override func addUI() {
        super.addUI()
        
        textInfoStackView.addArrangedSubviews(titleLabel, dateLabel)
        containerView.addSubviews(countryIconImageView, textInfoStackView, goIconImageView)
        addSubviews(containerView)
    }
    
    override func setupUI() {
        super.setupUI()
        
        containerView.snp.remakeConstraints { make in
            make.top.bottom.equalToSuperview().inset(2)
            make.leading.trailing.equalToSuperview().inset(8)
        }
        
        countryIconImageView.snp.remakeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize.countryIconImageViewSize)
        }
        
        goIconImageView.snp.remakeConstraints { make in
            make.trailing.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize.goIconImageViewSize)
        }
        
        textInfoStackView.snp.remakeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.leading.equalTo(countryIconImageView.snp.trailing).offset(16)
            make.trailing.equalTo(goIconImageView.snp.leading)
        }
    }
    
    override func configureUI() {
        super.configureUI()
        
        textInfoStackView.axis = .vertical
        textInfoStackView.spacing = 2
        
        dateLabel.font = .systemFont(ofSize: 15)
        dateLabel.textColor = .darkGray
        
        titleLabel.numberOfLines = 0
        dateLabel.numberOfLines = 0
        
        goIconImageView.image = .goImage
        
        containerView.layer.cornerRadius = 8
        containerView.backgroundColor = .white
        
        backgroundColor = .clear
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        countryIconImageView.image = nil
    }
}

extension NextLaunchCell: ConfigurableCell {
    func configure(with viewModel: NextLaunchCellViewModel) {
        countryIconImageView.image = CountryCodes.getImage(for: viewModel.launch.location.countryCode)
        titleLabel.text = viewModel.launch.name
        dateLabel.text = DateFormatterAPI.formatForCell(date: viewModel.launch.start)
    }
}

private extension CGSize {
    static let countryIconImageViewSize = CGSize(width: 44, height: 44)
    static let goIconImageViewSize = CGSize(width: 25, height: 25)
}
