//
//  ArticleCategoryTests.swift
//  SkierScribblerTests
//
//  Created by Owen Cruz-Abrams on 10/3/23.
//

import XCTest
@testable import SkierScribbler

final class ArticleCategoryTests: XCTestCase {

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
        for value in allValues {
            try testSpecificCategory(category: value)
        }
    }

    func testSpecificCategory(category: ArticleCategory) throws {
        let url = category.seralizeURL()
        let urlString = url.relativeString
        XCTAssertTrue(urlString.contains(urlFormat), "The URL for \(category) was badly formatted.")
        try XCTestURL(
            url: url,
            errorMessage: "An error occured when fetching \(category)'s web page. ",
            httpResponseFailureMessage: "An error occured when converting \(category)'s web page response to a HTTPURLResponse. ",
            not200ErrorMessage: "The response code for \(category)'s URL was not 200. "
        )
    }
// We no longer need this, as I created `XCTestUrl`.
//    func testNot404(url: URL, category: ArticleCategory) throws {
//        let expectation = self.expectation(description: "Completed fetch.")
//        let session = URLSession.shared
//        DispatchQueue(label: "Background test", qos: .userInitiated).async {
//            session.dataTask(with: url) {data, response, error in
//                if let error = error {
//                    XCTFail("An error was encountered when trying to request data from" +
//    "\(category)'s URL, \(url.relativeString). Error: \(error.localizedDescription)")
//                    return
//                }
//                // Convert the URL response to a HTTPURLResponse
//                guard let HTTPResponse = response as? HTTPURLResponse else {
//                    XCTFail("The response was not seralizeable to a HTTPURLResponse.")
//                    return
//                }
//                // Just b/c the status code is good doesn't mean we didn't get a 404 page.
//                XCTAssertTrue((200...299).contains(
//                    HTTPResponse.statusCode),
//                              "A response that was not in the 200 range resulted when trying to request data from"
//                              + "\(category)'s URL, \(url.relativeString). Response code: \(HTTPResponse.statusCode)"
//                )
//                guard let responseAsString = String(data: data ?? Data(), encoding: .utf8) else {
//                    XCTFail("Data could not be seralized into a String.")
//                    return
//                }
//                // Unnecessary - response code will already be 404.
//                XCTAssertFalse(responseAsString.contains("Not Found, Error 404"))
//                expectation.fulfill()
//            }.resume()
//        }
//        self.wait(for: [expectation])
//    }
    func testSeralizeURL() throws {
        // We just need to check that it is an article URL and not just the website
        for category in ArticleCategory.allCases {
            let url = category.seralizeURL()
            XCTAssertNotEqual(url, URL(string: "https://skierscribbler.com")!)
        }
    }

}
