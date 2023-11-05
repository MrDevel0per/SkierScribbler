//
//  WebFilter.swift
//  SkierScribbler
//
//  Created by Owen Cruz-Abrams on 9/19/23.
//

import Foundation

/// TODO: Docs (@MrDevel0per)
class WebFilter {

    /// Filters a URL based on pageContents and if it fits a predefined range.
    /// - parameter url: The ``URL`` that the user/view is trying to access.
    /// - parameter pageContents: A ``String`` of the contents of the website.
    static func filterURL(url: URL, pageContents: String) -> Bool {
        guard let regexes = FilterUtils.regexes else {
                return false
            }
        for reg in regexes {
                if url.absoluteString.contains(reg) {
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
