//
//  ArticleListItem.swift
//  SkierScribbler
//
//  Created by Owen Cruz-Abrams on 10/9/23.
//

import Foundation
import SwiftUI

//FIXME: Currently, the author's name and title both link to their page. Should this be changed to match the webpage, where only the name links up?

/// A view that displays an article's title, author, date, and teaser. This mimics the layout of skierscribbler.com
/// - Parameters:
///  - article: The ``Article`` to display
///  - showImage: A boolean that determines whether or not to show the article's image. Defaults to true.
struct ArticleListItem: View {
    var article: Article
    var showImage: Bool = true
    var image: Image? = nil
    var body: some View {
        VStack {
            if article.imageURL != nil {
                AsyncImage(url: article.imageURL) { img in
                    img
                        .resizable()
                        .scaledToFit()
                    
                    
                } placeholder: {
                    ProgressView()
                }
            }
            Text(article.title)
                .font(.title(.rokkitt))
                .multilineTextAlignment(.leading)
                .fontWeight(.semibold)
                .padding(1)
            HStack {
                NavigationLink(article.author.name + ", " + article.author.positionTitle, destination: {
                    MotherView()
                })
                .foregroundStyle(Color.linkRed)
                Text("•")
                Text(article.strDate)
                
            }.font(.body(.alegreya))
            
            Text(article.teaser)
                .font(.body(.alegreya))
                .padding(.horizontal)
                .padding(.vertical, 1)
                .multilineTextAlignment(.leading)
        }.navigationLink {
            MotherView()
        }
        .foregroundStyle(.primary)

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
