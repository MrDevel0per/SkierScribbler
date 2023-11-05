//
//  APIClient.swift
//  SkierScribbler
//
//  Created by Owen Cruz-Abrams on 9/20/23.
//

import Foundation
import SwiftSoup

/// The main interaction method with the SkierScribbler website.
/// - Note: For testability and infrastructure purposes, the ``APIClient`` **does not** impliment any parsing logic of its own. It uses the ``Parser`` internally in the ``APIClient.fetchAllArticles`` method, but all actual parsing logic is in the ``Parser``.
/// - seealso: ``Parser``, ``Article``, ``SwiftSoup.Document``
class APIClient {
    static let shared = APIClient()
    func fetchArticles(category: ArticleCategory) async -> SwiftSoup.Document {
        do {
            return try await fetchPage(at: category.seralizeURL())
        } catch {
            return Document("")
        }

    }

    // ???: Should this be moved from the `APIClient` to the views themselves?
    /// Get a list of every single SkierScribbler article on the server.
    /// - Returns: An array of `Article`s from the website.
    func fetchAllArticles() async -> [Article] {
        var returnable: [Article] = []
        for category in ArticleCategory.allCases {
            let doc = await fetchArticles(category: category)
            returnable += Parser.shared.parseCategory(category: doc)
        }

        // Unique "returnable"
        var uniqueArticleIDs = Set<Int>()

        returnable = returnable.filter({ art in
            if uniqueArticleIDs.contains(art.id) {
                    return false // Already seen this ID
                } else {
                    uniqueArticleIDs.insert(art.id) // Add the ID to the set
                    return true // New unique ID
                }
        })
        return returnable
    }

    func fetchPage(at url: URL) async throws -> SwiftSoup.Document {
        let request = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: request)
        let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
        guard (200...299).contains(statusCode) else {
            throw ClientError.fetchError(statusCode)
        }
        guard let decodedData = String(data: data, encoding: .utf8) else {
            throw ClientError.decodingError
        }
        return try SwiftSoup.parse(decodedData)
    }

}

// MARK: - Extensions
extension APIClient {
    enum ClientError: Error, Equatable {
        case fetchError(Int)
        case decodingError
        case parsingError
    }
}
