//
//  ShippingCell.swift
//  MamiLoveUI
//
//  Created by Vickyciou on 2023/9/18.
//

import UIKit

class ShippingCell: UITableViewCell {
    private lazy var titleLabel: UILabel = makeTitleLabel()
    private lazy var topShippingOptionLabel: UILabel = makeShippingOptionLabel()
    private lazy var topFreeThresholdLabel: UILabel = makeFreeThresholdLabel()
    private lazy var bottomShippingOptionLabel: UILabel = makeShippingOptionLabel()
    private lazy var bottomFreeThresholdLabel: UILabel = makeFreeThresholdLabel()
    private lazy var rightArrowButton: UIButton = makeRightArrowButton()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(topShippingOptionLabel)
        contentView.addSubview(topFreeThresholdLabel)
        contentView.addSubview(bottomShippingOptionLabel)
        contentView.addSubview(bottomFreeThresholdLabel)
        contentView.addSubview(rightArrowButton)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),

            topShippingOptionLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 16),
            topShippingOptionLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),

            topFreeThresholdLabel.leadingAnchor.constraint(equalTo: topShippingOptionLabel.trailingAnchor, constant: 8),
            topFreeThresholdLabel.topAnchor.constraint(equalTo: topShippingOptionLabel.topAnchor),

            bottomShippingOptionLabel.leadingAnchor.constraint(equalTo: topShippingOptionLabel.leadingAnchor),
            bottomShippingOptionLabel.topAnchor.constraint(equalTo: bottomFreeThresholdLabel.topAnchor),

            bottomFreeThresholdLabel.leadingAnchor.constraint(equalTo: bottomShippingOptionLabel.trailingAnchor ,constant: 8),
            bottomFreeThresholdLabel.topAnchor.constraint(equalTo: topFreeThresholdLabel.bottomAnchor,constant: 8),
            bottomFreeThresholdLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            rightArrowButton.leadingAnchor.constraint(equalTo: topFreeThresholdLabel.trailingAnchor, constant: 8),
            rightArrowButton.leadingAnchor.constraint(equalTo: bottomFreeThresholdLabel.trailingAnchor, constant: 8),
            rightArrowButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            rightArrowButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            rightArrowButton.widthAnchor.constraint(equalToConstant: 24),
            rightArrowButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }

    func setupShippingCell(title: String,
                          topShippingOption: String,
                          topFreeThreshold: String,
                          bottomShippingOption: String,
                          bottomFreeThreshold: String) {
        titleLabel.text = title
        topShippingOptionLabel.text = topShippingOption
        topFreeThresholdLabel.text = topFreeThreshold
        bottomShippingOptionLabel.text = bottomShippingOption
        bottomFreeThresholdLabel.text = bottomFreeThreshold
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ShippingCell {
    private func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.textColor = UIColor.darkGray
        return label
    }

    private func makeShippingOptionLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        label.textColor = UIColor.darkGray
        return label
    }

    private func makeFreeThresholdLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.textColor = UIColor.darkGray
        return label
    }

    private func makeRightArrowButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        button.setImage(UIImage(named: "rightArrow"), for: .normal)
        button.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
        return button
    }

    @objc func tappedButton() {
        print("open panel")
    }
}
