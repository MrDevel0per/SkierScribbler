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
            self.articles = await APIClient.shared.fetchAllArticles()
        }
    }
}
