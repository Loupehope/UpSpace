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
    private let circleImageView = UIImageView()
    
    override func addUI() {
        super.addUI()
        
        addSubview(circleImageView)
    }
    
    override func setupUI() {
        super.setupUI()
        
        circleImageView.snp.remakeConstraints { make in
            make.center.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(CGFloat.littleInset)
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
    }
}

extension CircleImageCell: ConfigurableCell {
    func configure(with model: CircleImageCellViewModel) {
        circleImageView.image = model.image
    }
}
