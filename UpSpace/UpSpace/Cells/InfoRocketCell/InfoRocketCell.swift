//
//  InfoRocketCell.swift
//  UpSpace
//
//  Created by Andrew on 09/05/2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

import TableKit
import UIKit

final class InfoRocketCell: BaseInitializableCell {
    private let containerView = UIView()
    private let rocketImage = UIImageView()
    private let nameLabel = UILabel()
    private let familyLabel = UILabel()
    private let configurationLabel = UILabel()
    
    override func addUI() {
        super.addUI()
        
        containerView.addSubviews([rocketImage, nameLabel, familyLabel, configurationLabel])
        addSubview(containerView)
    }
    
    override func setupUI() {
        super.setupUI()
        
        containerView.snp.remakeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(CGFloat.defaultInset)
        }
        
        rocketImage.snp.remakeConstraints { make in
            make.leading.equalToSuperview().inset(CGFloat.smallInset)
            make.top.bottom.equalToSuperview().inset(CGFloat.bigInset)
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
        
        nameLabel.snp.remakeConstraints { make in
            make.bottom.equalTo(familyLabel).inset(CGFloat.bigInset)
            make.leading.equalTo(rocketImage.snp.trailing).offset(CGFloat.bigInset)
        }

        familyLabel.snp.remakeConstraints { make in
            make.leading.equalTo(rocketImage.snp.trailing).offset(CGFloat.bigInset)
            make.centerY.equalTo(rocketImage)
        }

        configurationLabel.snp.remakeConstraints { make in
            make.top.equalTo(familyLabel).inset(CGFloat.bigInset)
            make.leading.equalTo(rocketImage.snp.trailing).offset(CGFloat.bigInset)
        }
    }
    
    override func configureUI() {
        super.configureUI()
        
        containerView.layer.cornerRadius = CGFloat.defaultCornerRadius
        containerView.backgroundColor = .whiteSpace
    }
}

extension InfoRocketCell: ConfigurableCell {
    func configure(with model: InfoRocketCellViewModel) {
        nameLabel.text = model.rocket.name
        familyLabel.text = model.rocket.familyname
        configurationLabel.text = model.rocket.configuration
    }
}
