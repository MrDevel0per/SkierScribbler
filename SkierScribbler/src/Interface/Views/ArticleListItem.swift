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
    var body: some View {
        VStack {
            // Display the article's image, if it has one
            articleImage()
            Spacer()
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
        }.navigationLink {
            MotherView()
        }
        .foregroundStyle(.primary)

    }
    
    @ViewBuilder private func articleImage() -> some View {
        GeometryReader { geo in
            if showImage {
                if let url = article.imageURL {
                    ViewThatFits(in: .vertical) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFill()
                            
                            
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    //TODO: Ensure this is the correct height
                    .frame(height: geo.size.height * 0.5)
                    
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ArticleListItem(article: Article.sampleArticle)
        ArticleListItem(article: Article.sampleArticle)
    }
    
}
