//
//  InfoLaunchHeaderCell.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 02/09/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import TableKit
import UIKit

final class InfoLaunchHeaderCell: BaseInitializableCell {
    private let containerView = UIView()
    private let titleLabel = UILabel()
    
    override func addUI() {
        super.addUI()
        
        containerView.addSubview(titleLabel)
        addSubview(containerView)
    }
    
    override func setupUI() {
        super.setupUI()
        
        titleLabel.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(8)
            make.top.bottom.equalToSuperview().inset(4)
        }
        
        containerView.snp.remakeConstraints { make in
            make.top.bottom.equalToSuperview().inset(4)
            make.leading.equalToSuperview().offset(16)
        }
    }

    override func configureUI() {
        super.configureUI()
        
        titleLabel.font = .systemFont(ofSize: 15)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        
        containerView.layer.cornerRadius = 8
        containerView.backgroundColor = .redSpace
        
        backgroundColor = .clear
    }
}

extension InfoLaunchHeaderCell: ConfigurableCell {
    func configure(with title: String) {
        titleLabel.text = title
    }
}
