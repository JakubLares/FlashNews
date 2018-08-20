//
//  ArticlesFeedTableViewCell.swift
//  PocketReader
//
//  Created by Jakub Lares on 20.08.18.
//  Copyright © 2018 Jakub Lares. All rights reserved.
//

import UIKit
import Kingfisher

class ArticlesFeedTableViewCell: UITableViewCell {

    static let identifier = "ArticlesFeedTableViewCell"

    private let iconImageView = RoundedCornerImageView(frame: .zero)
    private let titleLabel = UILabel()
    private let publishedLabel = UILabel()
    private let labelStackView = UIStackView()
    private var iconWidthConstraint: NSLayoutConstraint?

    private var iconVisible: Bool = true {
        didSet {
            iconWidthConstraint?.isActive = false
            iconWidthConstraint = iconImageView.widthAnchor.constraint(equalToConstant: iconVisible ? 40 : 0)
            iconWidthConstraint?.isActive = true
        }
    }

    // MARK: Init

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    // MARK: UI

    private func setupUI() {
        setupIconImageView()
        setupTitleLabel()
        setupPublishedLabel()
        setupLabelStackView()
        activateConstrains()
    }

    private func setupIconImageView() {
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(iconImageView)
    }

    private func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        titleLabel.textColor = .darkGray
        titleLabel.numberOfLines = 0
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        labelStackView.addArrangedSubview(titleLabel)
    }

    private func setupPublishedLabel() {
        publishedLabel.translatesAutoresizingMaskIntoConstraints = false
        publishedLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        publishedLabel.textColor = .lightGray
        publishedLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        labelStackView.addArrangedSubview(publishedLabel)
    }

    private func setupLabelStackView() {
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        labelStackView.axis = .vertical
        addSubview(labelStackView)
    }

    private func setupIconImageViewVisibility(_ url: URL?) {
        if let url = url {
            iconVisible = true
            iconImageView.kf.setImage(with: url)
        } else {
            iconVisible = false
        }
    }

    // MARK: Constraints

    private var iconImageViewConstraints: [NSLayoutConstraint] {
        return [
            iconImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 20),
            iconImageView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -20),
            iconImageView.heightAnchor.constraint(equalToConstant: 40),
        ]
    }

    private var labelStackViewConstraints: [NSLayoutConstraint] {
        return [
            labelStackView.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 8),
            labelStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            labelStackView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 8),
            labelStackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -8),
            labelStackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
    }

    private func activateConstrains() {
        NSLayoutConstraint.activate([
            iconImageViewConstraints,
            labelStackViewConstraints,
            ].flatMap({ $0 }))
    }

    // MARK: Logic

    func setup(_ model: ArticlesFeed.GetArticles.ArticleViewModel) {
        titleLabel.text = model.title
        publishedLabel.text = model.published
        setupIconImageViewVisibility(model.imageUrl)
    }
}
