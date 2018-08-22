//
//  ArticlesFeedRouter.swift
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

@objc protocol ArticlesFeedRoutingLogic {
    func routeToArticleWebView()
}

protocol ArticlesFeedDataPassing {
    var dataStore: ArticlesFeedDataStore? { get }
}

class ArticlesFeedRouter: NSObject, ArticlesFeedRoutingLogic, ArticlesFeedDataPassing {

    weak var viewController: ArticlesFeedViewController?
    var dataStore: ArticlesFeedDataStore?

    // MARK: Routing

    func routeToArticleWebView() {
        let destinationViewController = ArticleWebViewViewController()
        guard var destinationDataStore = destinationViewController.router?.dataStore,
            let dataStore = dataStore else { return }
        passDataToArticleWebView(source: dataStore, destination: &destinationDataStore)
        navigateToArticleWebView(source: viewController, destination: destinationViewController)
    }

    // MARK: Navigation

    func navigateToArticleWebView(source: ArticlesFeedViewController?, destination: ArticleWebViewViewController) {
        source?.navigationController?.pushViewController(destination, animated: true)
    }

    // MARK: Passing data

    func passDataToArticleWebView(source: ArticlesFeedDataStore, destination: inout ArticleWebViewDataStore) {
        destination.article = source.selectedArticle
    }
}