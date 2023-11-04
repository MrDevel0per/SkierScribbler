//
//  Article.swift
//  SkierScribbler
//
//  Created by Owen Cruz-Abrams on 9/20/23.
//

import Foundation
import SwiftSoup
// We don't care about line length for this file - it has to be long in some places
// swiftlint:disable line_length

/// The core `Article` type of the app, which stores the data for each SkierScribbler piece.
struct Article: Hashable, Equatable, Sendable {
    /// The `id` of the article, as identified in the URL. This is normally a four- or five-digit number, and is used as an ``Int``.
    var id: Int
    /// The category of the article. See ``ArticleCategory`` and its documentation for more info.
    var category: ArticleCategory
    //
    /// The actual title of the article, as defined on the website. This likely summarizes the article content or is a headline.
    /// - WARNING: WONTFIX: The Skier Scribbler website doesn't display subtitles immediately on the article page, so this sometimes looks janky or cut off.
    /// - Note: This doesn't include the subtitle! We don't store that in ``Article`` at all.
    var title: String
    /// The actual webpage URL where the article can be found. This is prefixed with `https://skierscribbler.com`, as that is where all articles are hosted.
    var url: URL
    /// The date of the article, provided as a ``String`` for easy display usage.
    /// - Note: The format of the `strDate` is `"MMMM dd, yyyy"`, so an example date would be `"November 16, 2023"` (note that it doesn't have 16**th**, just 16).
    var strDate: String
    /// The date that the article was published.
    var publishDate: Date
    /// The ``Author`` of the article.
    /// - seealso: ``Author``
    var author: Author
    /// The article's teaser content, usually about 150-220 characters.
    var teaser: String
    /// The `URL` of the article's image.
    /// - Warning: Not all articles have an image URL, so we have to handle edge cases!
    var imageURL: URL?

    init(id: Int, category: ArticleCategory, title: String, url: URL, publishDate: Date, author: Author, teaser: String = "", imageURL: URL? = nil) {
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
            self.teaser = "There was an error getting *\(title)* from the server, or the article doesn't have a teaser. Please refresh your feed or try again later."
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
// Article(id: \(self.id), category: SkierScribbler.ArticleCategory.\(String(describing: self.category)), title: "\(self.title)", url: URL(string: "\(self.url.absoluteString)")!, strDate: "\(self.strDate)", publishDate: Date(timeIntervalSince1970: \(self.publishDate.timeIntervalSince1970)), author: SkierScribbler.Author(name: "\(self.author.name)", positionTitle: "\(self.author.positionTitle), id: "\(self.author.id)", url: URL(string: "\(String(describing: self.author.url?.absoluteString))")!), teaser: "\(self.teaser)", imageURL: \(self.imageURL != nil ? "URL(string: \"\(self.imageURL?.absoluteString ?? "")\")!" : "nil"))
// """, terminator: "")
//    }
    // swiftlint:enable line_length
}
#endif
