//
//  ArticlesFeedInteractor.swift
//  PocketReader
//
//  Created by Jakub Lares on 18.08.18.
//  Copyright (c) 2018 Jakub Lares. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ArticlesFeedBusinessLogic {
    func getArticles()
    func getArticleDetail(_ row: Int)
    func shareArticle()
}

protocol ArticlesFeedDataStore {
    var selectedArticle: Article? { get set }
}

class ArticlesFeedInteractor: ArticlesFeedBusinessLogic, ArticlesFeedDataStore {
    
    var presenter: ArticlesFeedPresentationLogic?

    var selectedArticle: Article?
    private var articles: [Article]?
    private let networkWorker = NetworkWorker()
    private let shareWorker = ShareWorker()
    private let realmWorker = RealmWorker()

    func getArticles() {
        articles = realmWorker.loadArticles()
        presenter?.presentArticles(articles)
        networkWorker.getArticles(success: { [weak self] response in
            self?.articles = response.articles
            self?.realmWorker.saveArticles(self?.articles)
            self?.presenter?.presentArticles(self?.articles)
        }) { [weak self] error in
            self?.presenter?.presentError(error)
        }
    }

    func getArticleDetail(_ row: Int) {
        guard let article = articles?[row] else { return }
        selectedArticle = article
        presenter?.presentArticleDetail(article)
    }

    func shareArticle() {
        shareWorker.shareArticle(selectedArticle)
    }
}
