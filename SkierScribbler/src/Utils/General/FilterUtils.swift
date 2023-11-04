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
        guard let unwrappedLocation = (jsonLocation ?? Bundle.main.url(
            forResource: "allowed_urls", withExtension: "json"
        )) else {
            throw WebFilter.LoadingError.urlError
        }
        let jsonContents = try String(contentsOf: unwrappedLocation, encoding: .utf8)
        let decoder = JSONDecoder()
        let regexes = try decoder.decode(URLJSONFormat.self, from: jsonContents.data(using: .utf8) ?? Data())
        return [regexes.staffURLFormat, regexes.articleURLFormat]
    }
}
