//
//  URL+Category.swift
//  SkierScribbler
//
//  Created by Owen Cruz-Abrams on 10/7/23.
//

import Foundation

extension URL {
    // TODO: Documentation (@MrDevel0per)
    // FIXME: We HAVE to use a Regex instead, b/c otherwise the title can contain the category and cause an error
    var category: ArticleCategory {
        if self.isArticleURL {
            let splits = self.relativeString.split(separator: "/")
            for (index, content) in splits.enumerated() {
                // The first one is going to be skierscribbler.com
                if index <= 0 {
                    continue
                }

                // Check to see if the prior split was the ID (b/c then this next one is the category)
                if Int(splits[index-1]) != nil {
                    // Now loop over categories, and check to see if we can find a category in the text
                    if let category = ArticleCategory.allCategories().first(where: {$0.key == content.lowercased()}) {
                        return category.value
                    }

                }
            }

        }

        // If it can't be found, return `uncategorized`.
        return .uncategorized

    }

    /// The ID of the article.
    ///
    /// This is the number in the `URL` before the category. Examples:
    /// https://skierscribbler.com/12125/news/deer-to-vehical-collisions/ = 12125
    /// https://skierscribbler.com/1000/satire/owen-cruz-abrams-is-a-legend/ = 1000
    /// Example usage:
    /// ```swift
    /// let url = URL(string: "https://skierscribbler.com/12125/news/deer-to-vehical-collisions/")!
    /// print(url.id) // 12125
    /// ```
    var id: Int {
        // We need an article URL, otherwise, the ID is 0 (which is invalid)
        if self.isArticleURL {
            // We split by all "/" characters
            // This changes "https://" to "https:/"
            // so that we don't have an issue with two slashes "//"
            // This converts everything to a `Substring`, so we convert
            // it back to a string
            let splits = self.relativeString.replacingOccurrences(
                of: "//", with: "/"
            ).split(separator: "/").map { sub in
                // It's a substring, convert to a String
                String(sub)
            }
            // Loop over parts in between "/"s
            for split in splits {
                // Is it a valid integer (ID)?
                if let myID = Int(split) {
                    // YES - return it
                    return myID
                }
            }
        }
        // No ID was found, or it wasn't an article URL, so we return ID 0 (invalid)
        return 0
    }

    /// Whether the given `URL` is a URL for a SkierScribbler Article.
    var isArticleURL: Bool {
        guard let reg = FilterUtils.regexes?.last else {
            return false
        }
        if self.relativeString.contains(reg) {
            return true
        } else {
            return false
        }
    }

    /// If the URL is a URL for a SkierScribbler webpage.
    var isSkierScribbler: Bool {
        if let reg = try? Regex("(https://)?skierscribbler\\.com") {
            return self.relativeString.starts(with: reg)
        } else {
            return false
        }
    }
}

#if DEBUG
extension URL {
    static let sampleArticleURL: URL = URL(string: "https://skierscribbler.com/12125/news/deer-to-vehical-collisions/")!
}
#endif
