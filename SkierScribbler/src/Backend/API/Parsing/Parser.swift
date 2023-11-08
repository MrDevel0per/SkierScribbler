//
//  Parser.swift
//  SkierScribbler
//
//  Created by Owen Cruz-Abrams on 10/6/23.
//

import Foundation
import SwiftSoup

// Note that this parser must handle the edge case that an article is "uncategorized", like this one:
// https://skierscribbler.com/10076/uncategorized/scott-zevin/
// It doesn't have a typical format.
class Parser {

    // MARK: Public Interface
    public static var shared = Parser()

    public func parseCategory(category: SwiftSoup.Document) -> [Article] {
        do {
            return try parseCategory(category)
        } catch {
            #if DEBUG
            print("An error occured when fetching articles: \(error.localizedDescription)")
            #endif
            return []
        }

    }

    // MARK: - Implimentations
    // FIXME: This function only handles the first page of articles, not all of them. How can we make it load further?
    // TODO: TESTME
    /// A function to get all article URLs on a given webpage.
    /// - Parameter doc: The ``SwiftSoup.Document`` of the category's contents.
    /// - Returns: An array of `URLs` containing all articles in the document.
    private func parseCategory(_ doc: Document) throws -> [Article] {
//         TODO: Change to `Elements` to continue with the native SwiftSoup Types?
        var articleHTMLs: [Element] = []
        try doc.getElementsByTag("div").forEach({ element in
            if element.hasClass("catlist-panel-inner") {
                articleHTMLs.append(element)
            }
        })
        return try articleHTMLs.map { element in
            try parseArticleSubHTML(element)
        }
    }

        func parseArticleSubHTML(_ parentHTML: Element) throws -> Article {
        var id: Int
        var category: ArticleCategory
        var title: String
        var url: URL
        var publishDate: Date = Date()
        var author: Author
        var teaser: String
        var imageURL: URL?
        // MARK: Image
        // It's stored in the catlist-panel-media, which is a div, under as an img element.
        imageURL = try URL(string:
                            parentHTML.getElementsByClass("catlist-panel-media")
            .first()?.getElementsByTag("img").attr("src") ?? ""
        )

        // MARK: URL, which lets us get a lot of other things
        let titleComponent = try parentHTML.getElementsByClass("catlist-textarea-with-media").first()?
            .getElementsByTag("a").first()

        let unwrappedTitleComponent = try titleComponent ?? parentHTML.getElementsByClass("catlist-textarea").first()?
            .getElementsByTag("a").first()

        guard unwrappedTitleComponent != nil else {
            throw ParsingError.unableToFindURL
        }
        title = try unwrappedTitleComponent?.text() ?? "Untitled Article"
        let urlHTMLComponent = try unwrappedTitleComponent?.attr("href")

        guard let myurl = URL(string: urlHTMLComponent ?? "") else {
            throw ParsingError.unableToFindURL
        }
        url = myurl

        // MARK: ID + Category (implimented in Utils/URL+CustomTypes.swift)
        id = url.id
        category = url.category

        // MARK: Date Processing
        let dateFormatter = DateFormatter()
        let dateText = try parentHTML.getElementsByClass("catlist-date").first()?.text()
        // To initialize a date from a string like "October 15, 2023"
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        if let date = dateFormatter.date(from: dateText ?? "") {
            publishDate = date
        }

        // MARK: Author
        // Get the parent element - in this case the writer element
        let authorParentElement = try parentHTML.getElementsByClass("catlist-writer").first()
        // The title is stored in the format ", TITLE" under the text of the parent.
        // However, the below gets all sub text too, so we have to be careful.
        let nameAndTitleStr = try authorParentElement?.text() ?? ""
        // Get the link
        let authorURLContainer = try authorParentElement?.getElementsByTag("a").first()
        // Try to get its URL (href)
        let authorURL = URL(string: try authorURLContainer?.attr("href") ?? "")
        // Initialize w/ all these props
        author = Author(nameTitleString: nameAndTitleStr, url: authorURL)

        // MARK: Teaser
        // Format:
        // <div class="catlist-teaser">
        //     <p>The 2023-2024 sports season has officially started, some of which include cross country, football, softball, boys golf, and boys soccer. The teams have been working extremely hard, by training for many...</p>
        // </div>
        teaser = try parentHTML.getElementsByClass("catlist-teaser").text()
        return Article(
            id: id,
            category: category,
            title: title,
            url: url,
            publishDate: publishDate,
            author: author,
            teaser: teaser,
            imageURL: imageURL
        )
    }

}

extension Parser {
    enum ParsingError: Error {
        case unableToFindURL
        case dateParsingError(String)
    }
}
