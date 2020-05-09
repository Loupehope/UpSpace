//
//  NextLaunchView.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 03.05.2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

import SnapKit
import TableKit
import UIKit

final class NextLaunchCell: BaseInitializableCell {
    private let containerView = UIView()
    private let countryIconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    private let textInfoStackView = UIStackView()
    
    override func addUI() {
        super.addUI()
        
        textInfoStackView.addArrangedSubviews(titleLabel, dateLabel)
        containerView.addSubviews(countryIconImageView, textInfoStackView)
        addSubview(containerView)
    }
    
    override func setupUI() {
        super.setupUI()
        
        containerView.snp.remakeConstraints { make in
            make.top.bottom.equalToSuperview().inset(CGFloat.tinyInset)
            make.leading.trailing.equalToSuperview().inset(CGFloat.smallInset)
        }
        
        countryIconImageView.snp.remakeConstraints { make in
            make.leading.equalToSuperview().inset(CGFloat.defaultInset)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize.countryIconImageViewSize)
        }
        
        textInfoStackView.snp.remakeConstraints { make in
            make.top.bottom.equalToSuperview().inset(CGFloat.smallInset)
            make.leading.equalTo(countryIconImageView.snp.trailing).offset(CGFloat.defaultInset)
            make.trailing.equalToSuperview().inset(CGFloat.smallInset)
        }
    }
    
    override func configureUI() {
        super.configureUI()
        
        textInfoStackView.axis = .vertical
        textInfoStackView.spacing = .tinyInset
        
        dateLabel.font = .describingFont
        dateLabel.textColor = .darkGray
        
        titleLabel.numberOfLines = .zero
        dateLabel.numberOfLines = .zero
        
        containerView.layer.cornerRadius = .defaultCornerRadius
        containerView.backgroundColor = .white
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        countryIconImageView.image = nil
    }
}

extension NextLaunchCell: ConfigurableCell {
    func configure(with viewModel: NextLaunchCellViewModel) {
        countryIconImageView.image = viewModel.countryIcon
        titleLabel.text = viewModel.launchTitle
        dateLabel.text = viewModel.launchDate
    }
}

private extension CGSize {
    static let countryIconImageViewSize = CGSize(width: .defaultHeight, height: .defaultHeight)
}
