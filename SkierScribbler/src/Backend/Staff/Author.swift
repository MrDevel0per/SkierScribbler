//
//  Author.swift
//  SkierScribbler
//
//  Created by Owen Cruz-Abrams on 9/20/23.
//

import Foundation

struct Author: Codable, Identifiable {
    var name: String
    var positionTitle: String
    var description: String
    var photoURL: URL
    var id: String
    
    init(name: String, positionTitle: String, description: String, photoURL: URL) {
        self.name = name
        self.positionTitle = positionTitle
        self.description = description
        self.photoURL = photoURL
        self.id = name.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "-", with: "")
    }
    
}

// MARK: Extensions to Author type

#if DEBUG
extension Author {
    static let exampleAuthor = Author(name: "Test Author", positionTitle: "Application Test User", description: "Test Author serves no purpose other than being a test for displaying information.", photoURL: URL(string: "https://skierscribbler.com/wp-content/uploads/2022/05/Website-Header.jpg")!)
}

#endif
