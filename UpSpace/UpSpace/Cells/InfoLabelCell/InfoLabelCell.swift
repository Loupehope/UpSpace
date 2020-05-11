//
//  InfoLabelCell.swift
//  UpSpace
//
//  Created by Andrew on 09/05/2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

import TableKit
import UIKit

final class InfoLabelCell: BaseInitializableCell {
    private let containerView = UIView()
    private let titleLabel = UILabel()
    
    override func addUI() {
        super.addUI()
        containerView.addSubview(titleLabel)
        addSubview(containerView)
    }
    
    override func setupUI() {
        super.setupUI()
        
        containerView.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(CGFloat.defaultInset)
            make.top.bottom.equalToSuperview()
        }
        
        titleLabel.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(CGFloat.smallInset)
            make.top.bottom.equalToSuperview().inset(CGFloat.smallInset)
        }
    }
    
    override func configureUI() {
        super.configureUI()
        
        containerView.layer.cornerRadius = CGFloat.defaultCornerRadius
        containerView.backgroundColor = .whiteSpace
        
        titleLabel.numberOfLines = 0
    }
}

extension InfoLabelCell: ConfigurableCell {
    func configure(with model: InfoLabelCellViewModel) {
        titleLabel.text = model.text
    }
}
