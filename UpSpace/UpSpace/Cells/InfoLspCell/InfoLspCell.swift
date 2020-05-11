//
//  InfoLspCell.swift
//  UpSpace
//
//  Created by Andrew on 09/05/2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

import TableKit
import UIKit

final class InfoLspCell: BaseInitializableCell {
    private let containerView = UIView()
    private let lspNameLabel = UILabel()
    
    override func addUI() {
        super.addUI()
        containerView.addSubview(lspNameLabel)
        addSubview(containerView)
    }
    
    override func setupUI() {
        super.setupUI()
        
        containerView.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(CGFloat.defaultInset)
            make.top.bottom.equalToSuperview()
        }
        
        lspNameLabel.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(CGFloat.smallInset)
            make.top.bottom.equalToSuperview().inset(CGFloat.smallInset)
        }
    }
    
    override func configureUI() {
        super.configureUI()
        
        containerView.layer.cornerRadius = CGFloat.defaultCornerRadius
        containerView.backgroundColor = .whiteSpace
        
        lspNameLabel.numberOfLines = 0
    }
}

extension InfoLspCell: ConfigurableCell {
    func configure(with model: InfoLspCellViewModel) {
        lspNameLabel.text = model.lsp.name
    }
}
