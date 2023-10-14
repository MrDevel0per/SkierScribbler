//
//  MotherView.swift
//  SkierScribbler
//
//  Created by Owen Cruz-Abrams on 9/18/23.
//

import SwiftUI

/// The ``MotherView`` contains the overall heirarchy of the app.
///
/// It contains the ``TabView`` which has the four tabs of the app: Home, Print Editions, Search, and SkierTV.
struct MotherView: View {
    @State var articles: [Article] = []
    var body: some View {
            
            ScrollView {
                ForEach(articles, id: \.self) { article in
                    ArticleListItem(article: article)
                        .padding()
                    if articles.firstIndex(of: article) != articles.count - 1 {
                        Divider()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .ignoresSafeArea()
            .task {
                let doc = await APIClient.shared.fetchArticles(category: .news)
                articles = Parser.shared.parseCategory(category: doc)
                
            }
            .padding()
            .navigationTitle("The Skier Scribbler")
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    MotherView()
}
