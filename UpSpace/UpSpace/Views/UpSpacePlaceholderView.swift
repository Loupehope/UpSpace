//
//  UpSpacePlaceholderView.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 02.10.2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

final class UpSpacePlaceholderView: BaseInitializableView {
    private let disposeBag = DisposeBag()
    private let titleLabel = UILabel()
    private let actionButton = UIButton()
    private let activityView = UIActivityIndicatorView(appearance: .init(size: .large,
                                                                         color: .whiteSpace))
    private let invisibleView = UIView()

    override func addUI() {
        super.addUI()

        addSubviews(titleLabel, actionButton, activityView, invisibleView)
    }

    override func configureUI() {
        super.configureUI()

        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.textColor = .whiteSpace
        titleLabel.font = .systemFont(ofSize: 17, weight: .medium)

        activityView.isHidden = true
        
        actionButton.layer.cornerRadius = 12
        actionButton.backgroundColor = .darkGraySpace
        actionButton.setTitleColor(.white, for: .normal)
    }

    override func setupUI() {
        super.setupUI()

        invisibleView.snp.makeConstraints {
            $0.center.leading.trailing.equalToSuperview()
            $0.height.equalTo(0)
        }

        titleLabel.snp.makeConstraints {
            $0.bottom.equalTo(invisibleView.snp.top).inset(-10)
            $0.leading.trailing.equalToSuperview().inset(32)
        }

        actionButton.snp.makeConstraints {
            $0.top.equalTo(invisibleView.snp.top).inset(10)
            $0.width.equalTo(220)
            $0.height.equalTo(50)
            $0.centerX.equalToSuperview()
        }

        activityView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    // MARK: - Public

    func update(for state: State) {
        [titleLabel, actionButton].forEach { $0.isHidden = state == .loading }

        if state == .normal {
            activityView.stopAnimating()
        } else {
            activityView.startAnimating()
        }
    }
}

extension UpSpacePlaceholderView {
    enum State {
        case loading
        case normal
    }
}

// MARK: - ConfigurableView

extension UpSpacePlaceholderView {
    struct ViewModel {
        let title: String
        let buttonTitle: String
        let onButtonTapAction: (() -> Void)?
    }

    func configure(with viewModel: ViewModel) {
        titleLabel.text = viewModel.title
        
        actionButton.setTitle(viewModel.buttonTitle, for: .normal)
        actionButton.rx.tap.bind { viewModel.onButtonTapAction?() }.disposed(by: disposeBag)
    }
}
