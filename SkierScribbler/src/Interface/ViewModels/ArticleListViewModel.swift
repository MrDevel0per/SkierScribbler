//
//  ArticleListViewModel.swift
//  SkierScribbler
//
//  Created by Owen Cruz-Abrams on 10/15/23.
//

import Foundation
import SwiftUI

extension ArticleListView {
    class ArticleListViewModel: ObservableObject {
        @Published var articles: [Article] = []

        func fetchArticles() async {
            var returnableArticles: [Article] = await APIClient.shared.fetchAllArticles()
            // Sort by descending date - newest = first
            returnableArticles.sort {
                $0.publishDate > $1.publishDate
            }
            DispatchQueue.main.async { [returnableArticles] in
                self.articles = returnableArticles
            }
        }

        func isLastArticle(_ article: Article) -> Bool {
            articles.last == article
        }
    }
}
