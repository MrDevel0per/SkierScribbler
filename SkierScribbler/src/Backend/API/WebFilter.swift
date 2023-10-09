//
//  WebFilter.swift
//  SkierScribbler
//
//  Created by Owen Cruz-Abrams on 9/19/23.
//

import Foundation

/// TODO: Docs (@MrDevel0per)
class WebFilter {
    
    static func load_allowed_json_as_regex(json_location: URL) throws -> [Regex<AnyRegexOutput>] {
        let json_contents = try String(contentsOf: json_location, encoding: .utf8)
        let decoder = JSONDecoder()
        let urls = try decoder.decode(URLJSONFormat.self, from: json_contents.data(using: .utf8) ?? Data())
        return [try Regex(urls.staffURLFormat), try Regex(urls.articleURLFormat)]
    }
    
    /// Filters a URL based on pageContents and if it fits a predefined range.
    ///- parameter url: The ``URL`` that the user/view is trying to access.
    ///- parameter pageContents: A ``String`` of the contents of the website.
    static func filterURL(url: URL, pageContents: String) -> Bool {
        /// Allowed prefixes for URLs
        if let path = Bundle.main.path(forResource: "allowed_urls", ofType: "json"), let jsonURL = URLComponents(string: path){
            guard let url = jsonURL.url, let json = try? WebFilter.load_allowed_json_as_regex(json_location: url) else {
                return false
            }
            for i in json {
                if url.relativeString.contains(i) {
                    return true
                }
            }
            
            return false
        }
        return false
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
