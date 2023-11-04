//
//  ArticleCategory.swift
//  SkierScribbler
//
//  Created by Owen Cruz-Abrams on 9/20/23.
//

import Foundation

/// The `category` of the article, as it is tagged on the website.
enum ArticleCategory: String, Codable, CaseIterable, Sendable {
    /// The `satire` category of articles.
    case satire = "https://skierscribbler.com/category/satire/"
    /// The `news` category of articles.
    case news = "https://skierscribbler.com/category/news/"
    /// The `opinion` category of articles.
    case opinion = "https://skierscribbler.com/category/opinion/"
    /// The `artsAndEntertainment` (ae) category of articles.
    case artsAndEntertainment = "https://skierscribbler.com/category/ae/"
    /// The `sports` category of articles.
    case sports = "https://skierscribbler.com/category/sports/"
    /// The `showcase` category of articles.
    /// - Note: These articles are **always** tagged in another category, so they are duplicates.
    /// We have to remove these duplicates from the overall list. 
    /// This is here just in case.
    case showcase = "https://skierscribbler.com/category/showcase/"
    /// The `uncategorized` category of articles.
    /// - Note: There are very few articles with `uncategorized`.
    /// - Warning: An article that is `uncategorized` is likely an error. 
    /// These articles should be limited in visibility.
    case uncategorized = "https://skierscribbler.com/category/uncategorized/"
}

extension ArticleCategory {
    /// Get the URL for the article category.
    /// - returns: A `URL` of the category on the website.
    func seralizeURL() -> URL {
        return URL(string: self.rawValue) ?? URL(string: "https://skierscribbler.com")!
    }

    /// Get a `Dictionary` of all categories for ``ArticleCategory``.
    /// - WARNING: This **MUST** be updated with additions to ArticleCategory!
    /// - returns: A `Dictionary` with type `[String: ArticleCategory]`.
    /// This is a mapping of the raw category (NOT ITS URL) to the category enumeration.
    static func allCategories() -> [String: ArticleCategory] {
        [
            "satire": .satire,
            "ae": .artsAndEntertainment,
            "news": .news,
            "opinion": .opinion,
            "sports": .sports,
            "showcase": .showcase,
            "uncategorized": .uncategorized
        ]
    }
}
