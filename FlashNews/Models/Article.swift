//
//  Article.swift
//  PocketReader
//
//  Created by Jakub Lares on 21.08.18.
//  Copyright © 2018 Jakub Lares. All rights reserved.
//

import Foundation
import RealmSwift

struct Article: Decodable {
    let author, title, description, url: String?
    let urlToImage: String?
    let publishedAt: Date?
}

class ArticleRealm: Object {
    @objc dynamic var author: String? = nil
    @objc dynamic var title: String? = nil
    @objc dynamic var articleDescription: String? = nil
    @objc dynamic var url: String? = nil
    @objc dynamic var urlToImage: String? = nil
    @objc dynamic var publishedAt: Date? = nil
}
