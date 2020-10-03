//
//  NextLaunchView.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 03.05.2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

import LeadKit
import TableKit

final class NextLaunchCell: BaseInitializableCell {
    private let containerView = UIView()
    private let countryIconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    private let textInfoStackView = UIStackView()

    static var estimatedHeight: CGFloat? {
        60
    }

    override func addViews() {
        super.addViews()

        textInfoStackView.addArrangedSubviews(titleLabel, dateLabel)
        containerView.addSubviews(countryIconImageView, textInfoStackView)
        contentView.addSubview(containerView)
    }

    override func configureLayout() {
        super.configureLayout()

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

    override func configureAppearance() {
        super.configureAppearance()

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
        countryIconImageView.image = CountryCodes.getImage(for: viewModel.launch.location.countryCode)
        titleLabel.text = viewModel.launch.name
        dateLabel.text = DateFormatterAPI.formatForCell(date: viewModel.launch.start)
    }
}

private extension CGSize {
    static let countryIconImageViewSize = CGSize(width: .defaultHeight, height: .defaultHeight)
}
