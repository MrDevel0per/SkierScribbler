//
//  ArticleListItem.swift
//  SkierScribbler
//
//  Created by Owen Cruz-Abrams on 10/9/23.
//

import Foundation
import SwiftUI

// TODO: Make the author name open a `Sheet` with their page

/// A view that displays an article's title, author, date, and teaser. This mimics the layout of skierscribbler.com
/// - Parameters:
///  - article: The ``Article`` to display
///  - showImage: A boolean that determines whether or not to show the article's image. Defaults to true.
struct ArticleListItem: View {
    var article: Article
    var showImage: Bool = true
    var image: Image?
    var body: some View {
        VStack {
            if article.imageURL != nil {
                AsyncImage(url: article.imageURL) { img in
                    img
                        .resizable()
                        .scaledToFit()
                        .awareFrame(width: 1, height: 0.5)
                } placeholder: {
                    ProgressView()
                }
            }
                Text(article.title)
                    .font(.title(.rokkitt))
                    .fontWeight(.semibold)
                    .leftAlign()
                    .padding()

            HStack {
                authorMiniLink()
                Text("•")
                Text(article.strDate)

            }.font(.body(.alegreya))
                .leftAlign()
                .padding(.leading)
            Text(.init(article.teaser))
                .font(.body(.alegreya))
                .padding()
                .leftAlign()
        }.navigationLink {
            ArticleView(article: self.article)
        }
        .foregroundStyle(.primary)
        .draggable(article.url)

    }

}

#Preview {
    NavigationStack {
        ScrollView {
            ArticleListItem(article: Article.sampleArticle)
            Divider()
            ArticleListItem(article: Article.sampleArticle)
        }
    }

}

extension ArticleListItem {
    
    func authorNameString() -> String {
        return article.author.name == article.author.positionTitle ? article.author.name : "\(article.author.name), \(article.author.positionTitle)"
    }
    
    @ViewBuilder func authorMiniLink() -> some View {
        NavigationLink(authorNameString(), destination: {
            ArticleView(article: self.article)
        })
        .foregroundStyle(Color.linkRed)
        .lineLimit(1)
    }
}
