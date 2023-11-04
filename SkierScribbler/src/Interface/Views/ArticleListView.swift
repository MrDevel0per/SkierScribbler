//
//  ArticleListView.swift
//  SkierScribbler
//
//  Created by Owen Cruz-Abrams on 10/15/23.
//

import SwiftUI

struct ArticleListView: View {
    @StateObject var viewModel = ArticleListViewModel()
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
        .modifier(ScrollViewMods())
        .task {
            await viewModel.fetchArticles()
        }
    }
}

#Preview {
    ArticleListView()
}

extension ArticleListView {
    struct ScrollViewMods: ViewModifier {
        func body(content: Content) -> some View {
            content
                .scrollIndicators(.hidden)
                    .navigationTitle("The Skier Scribbler")
                    .navigationBarTitleDisplayMode(.inline)
        }
    }
}
