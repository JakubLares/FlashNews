//
//  ArticlesFeedDetailView.swift
//  PocketReader
//
//  Created by Jakub Lares on 18.08.18.
//  Copyright © 2018 Jakub Lares. All rights reserved.
//

import UIKit

class ArticlesFeedDetailView: UIView {

    private let detailImageView = RoundedCornerImageView(frame: .zero)
    private let separatorView = UIView()
    private let titleLabel = UILabel()
    private let publishedLabel = UILabel()
    private let authorLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let stackView = UIStackView()

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    // MARK: UI

    private func setupUI() {
        addSubviewForAutoLayout(detailImageView)
        setupSeparatorView()
        setupStackView()
        setupTitleLabel()
        setupPublished()
        setupAuthorLabel()
        setupDescriptionLabel()
        activateConstraints()
    }

    private func setupSeparatorView() {
        separatorView.backgroundColor = .lightGray
        addSubviewForAutoLayout(separatorView)
    }

    private func setupStackView() {
        stackView.axis = .vertical
        addSubviewForAutoLayout(stackView)
    }

    private func setupTitleLabel() {
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        titleLabel.textColor = .darkGray
        titleLabel.numberOfLines = 2
        stackView.addArrangedSubview(titleLabel)
    }

    private func setupPublished() {
        publishedLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        publishedLabel.textColor = .lightGray
        stackView.addArrangedSubview(publishedLabel)
    }

    private func setupAuthorLabel() {
        authorLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        authorLabel.textColor = .lightGray
        stackView.addArrangedSubview(authorLabel)
    }

    private func setupDescriptionLabel() {
        descriptionLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        descriptionLabel.textColor = .black
        descriptionLabel.numberOfLines = 0
        stackView.addArrangedSubview(descriptionLabel)
    }

    // MARK: Constraints

    private var detailImageViewConstraints: [NSLayoutConstraint] {
        return [
            detailImageView.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            detailImageView.leftAnchor.constraint(equalTo: leftAnchor , constant: 20),
            detailImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
            detailImageView.widthAnchor.constraint(equalTo: detailImageView.heightAnchor, multiplier: 1)
        ]
    }

    private var separatoViewContraints: [NSLayoutConstraint] {
        return [
            separatorView.rightAnchor.constraint(equalTo: rightAnchor),
            separatorView.leftAnchor.constraint(equalTo: leftAnchor),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ]
    }

    private var stackViewConstraints: [NSLayoutConstraint] {
        return [
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            stackView.leftAnchor.constraint(equalTo: detailImageView.rightAnchor, constant: 8),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ]
    }

    private func activateConstraints() {
        NSLayoutConstraint.activate([
            detailImageViewConstraints,
            separatoViewContraints,
            stackViewConstraints
            ].flatMap({ $0 }))
    }

    // MARK: Public methods

    func setup(_ articleDetail: ArticlesFeed.GetArticleDetail.ViewModel) {
        OperationQueue.main.addOperation { [weak self] in
            self?.detailImageView.kf.setImage(with: articleDetail.imageUrl)
            self?.titleLabel.text = articleDetail.title
            self?.publishedLabel.text = articleDetail.published
            self?.authorLabel.text = articleDetail.author
            self?.descriptionLabel.text = articleDetail.description
        }
    }
}
