//
//  WebFilterTests.swift
//  SkierScribblerTests
//
//  Created by Owen Cruz-Abrams on 10/5/23.
//

import XCTest
@testable import SkierScribbler

// TODO: Impliment tests for URLs embedded in pageContents
final class WebFilterTests: XCTestCase {
    var allowedArticleURLs = [URL]()
    var allowedStaffURLs = [URL]()
    var disallowedURLs = [URL]()
    override func setUpWithError() throws {
        allowedArticleURLs = [
            "https://skierscribbler.com/12151/ae/ferris-buellers-day-off/",
            "https://skierscribbler.com/12259/news/kickoff-to-the-fall-season/",
            "https://skierscribbler.com/12224/opinion/sonorities/",
            "https://skierscribbler.com/1455/news/new-ahs-teacher-david-fregly/",
            "https://skierscribbler.com/12008/showcase/spray-tan-booth-opening/",
            "https://skierscribbler.com/12271/news/2024-paris-olympics/"
        ].map { str in
            URL(string: str)!
        }
        allowedStaffURLs = [
            "https://skierscribbler.com/staff_name/quintessa-frisch/",
            "https://skierscribbler.com/staff_name/gia-galindo-bartley/"
        ].map { str in
            URL(string: str)!
        }
        disallowedURLs = [
            "https://skierscribbler.com/about/staff/",
            "skierscribbler.com",
            "https://skierscribbler.com/print-issues/",
            "https://issuu.com/solutions?utm_medium=referral&utm_source=https://skierscribbler.com/1455/news/refderfd-xxxxx",
            "https://skierscribbler.com/about/staff/",
            "https://skierscribbler.com/12259/news/kickoff-to-the-fall-season/xxxxxxx"
        ].map { str in
            URL(string: str)!
        }
    }

    func testLoadJSON() throws {
        // First, ensure it doesn't throw.
        XCTAssertNoThrow(try FilterUtils.loadAllowedJSON())
        let result = try FilterUtils.loadAllowedJSON()
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result[0], "^(https://)?skierscribbler\\.com\\/staff_name\\/[a-z -]+[\\/]?$")
        XCTAssertEqual(result[1], "^(https://)?skierscribbler\\.com\\/\\d{4,5}\\/[a-z]+\\/[a-z \\d -]+[\\/]?$")
    }

    func testFilter() throws {
        for url in allowedArticleURLs {
            XCTAssertTrue(WebFilter.filterURL(url: url, pageContents: ""))
        }
        for url in allowedStaffURLs {
            XCTAssertTrue(WebFilter.filterURL(url: url, pageContents: ""))
        }
        for url in disallowedURLs {
            XCTAssertFalse(WebFilter.filterURL(url: url, pageContents: ""))
        }
    }
    func testFilterPerformance() throws {
        self.measure {
            _ = WebFilter.filterURL(url: allowedArticleURLs[0], pageContents: "")
        }
    }

}
