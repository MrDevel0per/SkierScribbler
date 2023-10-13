//
//  APIClient.swift
//  SkierScribbler
//
//  Created by Owen Cruz-Abrams on 9/20/23.
//

import Foundation
import SwiftSoup

class APIClient {
    static let shared = APIClient()
    func fetchArticles(category: ArticleCategory) async -> SwiftSoup.Document {
        do {
            return try await fetchPage(at: category.seralizeURL())
        } catch {
            return Document("")
        }
        
    }
    
    func parseAuthorPage(page: URL) -> Author {
        return Author.sampleAuthor
    }
    
    func parseAllArticles() -> [Article] {
        []
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

//MARK: - Extensions
extension APIClient {
    enum ClientError: Error, Equatable {
        case fetchError(Int)
        case decodingError
        case parsingError
    }
}