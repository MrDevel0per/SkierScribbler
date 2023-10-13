//
//  Article.swift
//  SkierScribbler
//
//  Created by Owen Cruz-Abrams on 9/20/23.
//

import Foundation
import SwiftSoup

struct Article: Hashable, Equatable {
    var id: Int
    var category: ArticleCategory
    var title: String
    var url: URL
    var strDate: String
    var publishDate: Date
    var author: Author
    var teaser: String
    var imageURL: URL?
    
    init(id: Int, category: ArticleCategory, title: String, url: URL, publishDate: Date, author: Author, teaser: String, imageURL: URL? = nil) {
        self.id = id
        self.category = category
        self.title = title
        self.url = url
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        self.strDate = formatter.string(from: publishDate)
        self.publishDate = publishDate
        self.author = author
        if teaser == "" {
            self.teaser = "There was an error when fetching the article '\(title)' from the server. Please try again later."
        } else {
            self.teaser = teaser
        }
        self.imageURL = imageURL
    }
}

#if DEBUG
extension Article {
    static var sampleArticle: Self = Article(id: 0, category: .uncategorized, title: "Sample Article", url: URL.sampleArticleURL, publishDate: Date(), author: Author.sampleAuthor, teaser: "This is a teaser for the sample article, written in such a way that it has the correct number of characters for a teaser (204). This is a very interesting article, and will load the sampleArticleURL if...", imageURL: URL(string: "https://www.rangefinderonline.com/wp-content/uploads/2021/08/B23A9251-Edit.jpg")!)
    
//    func printSelf() {
//        print("""
//Article(id: \(self.id), category: SkierScribbler.ArticleCategory.\(String(describing: self.category)), title: "\(self.title)", url: URL(string: "\(self.url.absoluteString)")!, strDate: "\(self.strDate)", publishDate: Date(timeIntervalSince1970: \(self.publishDate.timeIntervalSince1970)), author: SkierScribbler.Author(name: "\(self.author.name)", positionTitle: "\(self.author.positionTitle), id: "\(self.author.id)", url: URL(string: "\(String(describing: self.author.url?.absoluteString))")!), teaser: "\(self.teaser)", imageURL: \(self.imageURL != nil ? "URL(string: \"\(self.imageURL?.absoluteString ?? "")\")!" : "nil"))
//""", terminator: "")
//    }
}
#endif
