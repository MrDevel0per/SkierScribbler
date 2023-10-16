//
//  ArticleListView.swift
//  SkierScribbler
//
//  Created by Owen Cruz-Abrams on 10/15/23.
//

import SwiftUI

struct ArticleListView: View {
    var viewModel = ArticleListViewModel()
    var body: some View {
            
            ScrollView {
                ForEach(viewModel.articles, id: \.self) { article in
                    ArticleListItem(article: article)
                        .padding()
                    if viewModel.articles.firstIndex(of: article) != viewModel.articles.count - 1 {
                        Divider()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .ignoresSafeArea()
            .task {
                await viewModel.fetchArticles()
                
            }
            .padding()
            .navigationTitle("The Skier Scribbler")
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ArticleListView()
}
