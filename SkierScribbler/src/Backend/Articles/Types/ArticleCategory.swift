//
//  ArticleCategory.swift
//  SkierScribbler
//
//  Created by Owen Cruz-Abrams on 9/20/23.
//

import Foundation



//TODO: Docs (@MrDevel0per)
enum ArticleCategory: String, Codable, CaseIterable, Sendable {
    case satire = "https://skierscribbler.com/category/satire/"
    case news = "https://skierscribbler.com/category/news/"
    case opinion = "https://skierscribbler.com/category/opinion/"
    case ae = "https://skierscribbler.com/category/ae/"
    case sports = "https://skierscribbler.com/category/sports/"
    case showcase = "https://skierscribbler.com/category/showcase/"
    case uncategorized = "https://skierscribbler.com/category/uncategorized/"
}

extension ArticleCategory {
    /// Get the URL for the article category.
    /// - returns: A `URL` of the category on the website.
    func seralizeURL() -> URL {
        return URL(string: self.rawValue) ?? URL(string: "https://skierscribbler.com")!
    }
    
    static func allCategories() -> [String: ArticleCategory] {
        ["satire": .satire, "ae": .ae, "news": .news, "opinion": .opinion, "sports": .sports, "showcase": .showcase, "uncategorized": .uncategorized]
    }
}
