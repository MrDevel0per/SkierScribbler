//
//  Author.swift
//  SkierScribbler
//
//  Created by Owen Cruz-Abrams on 9/20/23.
//

import Foundation

struct Author: Codable, Identifiable, Hashable, Equatable {
    var name: String
    var positionTitle: String
    var id: String
    var url: URL?

    init(name: String, positionTitle: String, url: URL?) {
        self.name = name
        self.positionTitle = positionTitle
        self.id = name.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "-", with: "").lowercased()
        self.url = url
    }

    init(nameTitleString: String, url: URL?) {
        let split = nameTitleString.split(separator: ", ")
        self.init(
            name: String(split.first ?? "No Author Name"),
            positionTitle: String(split.last ?? "Unknown Position"),
            url: url
        )
    }

    // TODO: TESTME
    init(name: String, positionTitle: String) {
        self.name = name
        self.positionTitle = positionTitle
        self.url = URL(string:
                        "https://skierscribbler.com/staff_name/\(name.replacingOccurrences(of: " ", with: "-"))/"
        )
        self.id = name.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "-", with: "").lowercased()
    }

    init(name: String, positionTitle: String, id: String, url: URL?) {
        self.name = name
        self.positionTitle = positionTitle
        self.id = id
        self.url = url
    }

}

// MARK: Extensions to Author type

#if DEBUG
extension Author {
    static let sampleAuthor = Author(name: "Test Author", positionTitle: "Application Test User")
}

#endif
