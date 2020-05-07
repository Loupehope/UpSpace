//
//  CircleImageCell.swift
//  UpSpace
//
//  Created by Andrew on 07/05/2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

import TableKit
import UIKit

final class CircleImageCell: BaseInitializableCell {
    private let containerView = UIView()
    private let circleImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initializeUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        initializeUI()
    }
    
    override func addUI() {
        super.addUI()
        
        containerView.addSubview(circleImageView)
        addSubview(containerView)
    }
    
    override func setupUI() {
        super.setupUI()
        
        circleImageView.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(CGFloat.smallInset)
            make.top.bottom.equalToSuperview().inset(CGFloat.littleInset)
        }
        
        containerView.snp.remakeConstraints { make in
            make.top.bottom.equalToSuperview().inset(CGFloat.littleInset)
            make.leading.equalToSuperview().offset(CGFloat.defaultInset)
        }
    }
    
    override func configureUI() {
        super.configureUI()
        
        containerView.backgroundColor = .tableViewSpace
    }
}

extension CircleImageCell: ConfigurableCell {
    func configure(with model: CircleImageCellViewModel) {
        circleImageView.image = UIImage(named: model.image ?? .empty)
    }
}
