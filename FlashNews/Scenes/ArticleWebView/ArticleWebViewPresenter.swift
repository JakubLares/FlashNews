//
//  ArticleWebViewPresenter.swift
//  PocketReader
//
//  Created by Jakub Lares on 20.08.18.
//  Copyright (c) 2018 Jakub Lares. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ArticleWebViewPresentationLogic {
    func presentArticleUrl(_ url: String?)
}

class ArticleWebViewPresenter: ArticleWebViewPresentationLogic {

    weak var viewController: ArticleWebViewDisplayLogic?

    func presentArticleUrl(_ urlString: String?) {
        guard let urlString = urlString,
            let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        viewController?.displayArticleUrl(viewModel: ArticleWebView.GetArticleUrl.ViewModel(urlRequest: request))
    }
}