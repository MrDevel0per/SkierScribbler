//
//  WebFilter.swift
//  SkierScribbler
//
//  Created by Owen Cruz-Abrams on 9/19/23.
//

import Foundation

// TODO: Change to opening a popup when it is a non-SkierScribbler URL
/// The filter for all content going in and out of our ``WebViewBridge``.
///
/// - Note: The filter will, by default, allow the user to go to any page that is linked to the current page. However, it will return that a popup is required if it doesn't link to another article.
class WebFilter {

    /// Filters a URL based on pageContents and if it fits a predefined range.
    /// - parameter url: The ``URL`` that the user/view is trying to access.
    /// - parameter pageContents: A ``String`` of the contents of the website.
    static func filterURL(url: URL, pageContents: String) -> Bool {
        // Load regexes for staff and article URLs
        guard let regexes = FilterUtils.regexes else {
                return false
            }
        // It's a staff/article URL
        if regexes.first(where: { reg in
            url.absoluteString.contains(reg)
        }) != nil {
            return true
        }
        // Check page contents
        if pageContents.localizedCaseInsensitiveContains(url.relativeString) {
            // We don't want to let the user go to home or category pages
            if !url.isSkierScribbler {
                return true
            }
        }
        return false
    }
}

// MARK: - Extensions

extension WebFilter {
    enum LoadingError: Error {
     case urlError
    }
}

struct URLJSONFormat: Codable {
    var staffURLFormat: String
    var articleURLFormat: String
    enum CodingKeys: String, CodingKey {
        case staffURLFormat = "staff_url_format"
        case articleURLFormat = "article_url_format"
    }
}
