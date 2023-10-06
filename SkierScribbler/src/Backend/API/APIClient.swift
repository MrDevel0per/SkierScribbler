//
//  APIClient.swift
//  SkierScribbler
//
//  Created by Owen Cruz-Abrams on 9/20/23.
//

import Foundation

class APIClient {
    func fetchArticles(category: ArticleCategory) -> [Article] {
        let categoryURL = category.seralizeURL()
        return []
    }
    
    func parseAuthorPage(page: URL) -> Author {
        return Author.exampleAuthor
    }
    
    func parseAllArticles() -> [Article] {
        []
    }
}
