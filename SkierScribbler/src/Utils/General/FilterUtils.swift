//
//  FilterUtils.swift
//  SkierScribbler
//
//  Created by Owen Cruz-Abrams on 10/7/23.
//

import Foundation

class FilterUtils {
    static var regexes = try? loadAllowedJSON().compactMap { str in
        try? Regex(str)
    }
    static func loadAllowedJSON(_ jsonLocation: URL? = nil) throws -> [String] {
        let _loc = jsonLocation ?? Bundle.main.url(forResource: "allowed_urls", withExtension: "json")
        guard let loc = _loc else {
            throw WebFilter.LoadingError.urlError
        }
        let json_contents = try String(contentsOf: loc, encoding: .utf8)
        let decoder = JSONDecoder()
        let urls = try decoder.decode(URLJSONFormat.self, from: json_contents.data(using: .utf8) ?? Data())
        return [urls.staffURLFormat, urls.articleURLFormat]
    }
    

}
