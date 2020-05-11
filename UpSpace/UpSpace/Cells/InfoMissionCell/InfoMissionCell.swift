//
//  InfoMissionCell.swift
//  UpSpace
//
//  Created by Andrew on 09/05/2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

import TableKit
import UIKit

final class InfoMissionCell: BaseInitializableCell {
    private let containerView = UIView()
    private let nameLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    override func addUI() {
        super.addUI()
        
        containerView.addSubviews(nameLabel, descriptionLabel)
        addSubview(containerView)
    }
    
    override func setupUI() {
        super.setupUI()
        
        containerView.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(CGFloat.defaultInset)
            make.top.bottom.equalToSuperview()
        }
        
        nameLabel.snp.remakeConstraints { make in
            make.top.equalToSuperview().inset(CGFloat.smallInset)
            make.leading.trailing.equalToSuperview().inset(CGFloat.smallInset)
        }
        
        descriptionLabel.snp.remakeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(CGFloat.defaultInset)
            make.leading.trailing.equalToSuperview().inset(CGFloat.smallInset)
            make.bottom.equalToSuperview().inset(CGFloat.smallInset)
        }
    }
    
    override func configureUI() {
        super.configureUI()
        
        containerView.layer.cornerRadius = CGFloat.defaultCornerRadius
        containerView.backgroundColor = .whiteSpace
        
        nameLabel.numberOfLines = 0
        descriptionLabel.numberOfLines = 0
    }
}

extension InfoMissionCell: ConfigurableCell {
    func configure(with model: InfoMissionCellViewModel) {
        nameLabel.text = model.mission.name
        descriptionLabel.text = model.mission.description
    }
}
