//
//  ArticlesFeedViewController.swift
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

protocol ArticlesFeedDisplayLogic: class {
    func displayArticles(_ viewModel: ArticlesFeed.GetArticles.ViewModel)
    func displayArticleDetail(_ viewModel: ArticlesFeed.GetArticleDetail.ViewModel)
    func displayAlert(_ alert: UIAlertController)
}

class ArticlesFeedViewController: UIViewController, ArticlesFeedDisplayLogic {
    private var interactor: ArticlesFeedBusinessLogic?
    private var router: (NSObjectProtocol & ArticlesFeedRoutingLogic & ArticlesFeedDataPassing)?

    private var articlesViewModel = ArticlesFeed.GetArticles.ViewModel(articles: [])

    private let detailView = ArticlesFeedDetailView()
    private let feedTableView = UITableView()
    
    // MARK: Init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = ArticlesFeedInteractor()
        let presenter = ArticlesFeedPresenter()
        let router = ArticlesFeedRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        interactor?.getArticles()
    }

    // MARK: Setup UI

    private func setupUI() {
        view.backgroundColor = .white
        setupNavigationBar()
        setupNavigationBar()
        setupDetailView()
        setupFeedTableView()
        activateConstraints()
    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        addShareButton(action: #selector(shareButtonPressed))
    }

    private func setupDetailView() {
        detailView.translatesAutoresizingMaskIntoConstraints = false
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(detailViewPressed))
        detailView.addGestureRecognizer(gestureRecognizer)
        view.addSubview(detailView)
    }

    private func setupFeedTableView() {
        feedTableView.translatesAutoresizingMaskIntoConstraints = false
        feedTableView.delegate = self
        feedTableView.dataSource = self
        feedTableView.register(ArticlesFeedTableViewCell.self, forCellReuseIdentifier: ArticlesFeedTableViewCell.identifier)
        feedTableView.rowHeight = UITableViewAutomaticDimension
        feedTableView.tableFooterView = UIView(frame: .zero)
        view.addSubview(feedTableView)
    }

    // MARK: Constraints

    private var detailViewConstraints: [NSLayoutConstraint] {
        return [
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.rightAnchor.constraint(equalTo: view.rightAnchor),
            detailView.leftAnchor.constraint(equalTo: view.leftAnchor),
            detailView.heightAnchor.constraint(equalToConstant: 200)
        ]
    }

    private var feedTableViewConstraints: [NSLayoutConstraint] {
        return [
            feedTableView.topAnchor.constraint(equalTo: detailView.bottomAnchor),
            feedTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            feedTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            feedTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
    }

    private func activateConstraints() {
        NSLayoutConstraint.activate([
            detailViewConstraints,
            feedTableViewConstraints
            ].flatMap({ $0 }))
    }

    // MARK: Display

    func displayArticles(_ viewModel: ArticlesFeed.GetArticles.ViewModel) {
        articlesViewModel = viewModel
        OperationQueue.main.addOperation { [weak self] in
            self?.feedTableView.reloadData()
        }
        if !articlesViewModel.articles.isEmpty {
            interactor?.getArticleDetail(0)
        }
    }

    func displayArticleDetail(_ viewModel: ArticlesFeed.GetArticleDetail.ViewModel) {
        detailView.setup(viewModel)
    }

    func displayAlert(_ alert: UIAlertController) {
        present(alert, animated: true, completion: nil)
    }

    // MARK: Logic

    @objc private func shareButtonPressed() {

    }

    @objc func detailViewPressed() {
        router?.routeToArticleWebView()
    }
}

extension ArticlesFeedViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articlesViewModel.articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticlesFeedTableViewCell.identifier, for: indexPath)
        (cell as? ArticlesFeedTableViewCell)?.setup(articlesViewModel.articles[indexPath.row])
        return cell
    }
}

extension ArticlesFeedViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor?.getArticleDetail(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
