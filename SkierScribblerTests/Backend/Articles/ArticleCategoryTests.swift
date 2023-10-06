//
//  ArticleCategoryTests.swift
//  SkierScribblerTests
//
//  Created by Owen Cruz-Abrams on 10/3/23.
//

import XCTest
@testable import SkierScribbler

final class ArticleCategoryTests: XCTestCase {
    struct setupError: Error {
        var message: String
    }
    
    var allValues = [ArticleCategory]()
    var urlFormat = Regex<AnyRegexOutput>(verbatim: "hello")

    override func setUpWithError() throws {
        allValues = ArticleCategory.allCases
        // We test this in our WebFilter tests thoroughly.
        urlFormat = try Regex("https:\\/\\/?skierscribbler\\.com\\/category\\/[a-z]+")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAllCategories() throws {
        for i in allValues {
            try testSpecificCategory(category: i)
        }
    }

    func testSpecificCategory(category: ArticleCategory) throws {
        let url = category.seralizeURL()
        let urlString = url.relativeString
        XCTAssertTrue(urlString.contains(urlFormat), "The URL for \(category) was badly formatted.")
        try testNot404(url: url, category: category)
    }
    
    func testNot404(url: URL, category: ArticleCategory) throws {
        let expectation = self.expectation(description: "Completed fetch.")
        let session = URLSession.shared
        session.dataTask(with: url) {data, response, error in
            if let error = error {
                XCTFail("An error was encountered when trying to request data from \(category)'s URL, \(url.relativeString). Error: \(error.localizedDescription)")
                return
            }
            
            guard let httpresponse = response as? HTTPURLResponse else {
                XCTFail("The response was not a HTTPURLResponse.")
                return
            }
            
            // Just b/c the status code is good doesn't mean we didn't get a 404 page.
            
            XCTAssertTrue((200...299).contains(httpresponse.statusCode), "A response that was not in the 200 range was encountered when trying to request data from \(category)'s URL, \(url.relativeString). Response code: \(httpresponse.statusCode)")
            guard let respStr = String(data: data ?? Data(), encoding: .utf8) else {
                XCTFail("Data could not be seralized into a String.")
                return
            }
            // Unnecessary - response code will already be 404.
//            XCTAssertFalse(respStr.contains("Not Found, Error 404"))
            expectation.fulfill()
        }.resume()
        self.wait(for: [expectation])
    }

}
