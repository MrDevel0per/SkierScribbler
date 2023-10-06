//
//  Article.swift
//  SkierScribbler
//
//  Created by Owen Cruz-Abrams on 9/20/23.
//

import Foundation

struct Article: Codable {
    var id: String
    var category: ArticleCategory
    var title: String
    var url: URL
    var publishDate: Date
    var author: Author
    var teaser: String
    var imageURL: URL?
}
