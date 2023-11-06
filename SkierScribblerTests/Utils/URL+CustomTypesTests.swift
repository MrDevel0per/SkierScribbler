//
//  URL+CategoryTests.swift
//  SkierScribblerTests
//
//  Created by Owen Cruz-Abrams on 10/7/23.
//

import XCTest
@testable import SkierScribbler

final class URLCustomTypesTests: XCTestCase {
    let invalidArticles = [
        "https://skierscribbler.com/staff_name/quintessa-frisch/",
        "https://skierscribbler.com/staff_name/gia-galindo-bartley/",
        "https://skierscribbler.com/about/staff/", "skierscribbler.com",
        "https://skierscribbler.com/print-issues/",
        "https://skierscribbler.com/about/staff/",
        "https://skierscribbler.com/12259/news/kickoff-to-the-fall-season/xxxxxxx",
        "https://issuu.com/solutions?utm_medium=referral&utm_source=https://skierscribbler.com/1455/news/refderfd-xxxxx"
    ].map { str in
        URL(string: str)!
    }

    let yeses = [
        "https://skierscribbler.com/12151/ae/ferris-buellers-day-off/",
        "https://skierscribbler.com/12259/news/kickoff-to-the-fall-season/",
        "https://skierscribbler.com/12224/opinion/sonorities/",
        "https://skierscribbler.com/1455/news/new-ahs-teacher-david-fregly/",
        "https://skierscribbler.com/12008/showcase/spray-tan-booth-opening/"
    ].map { str in
        URL(string: str)!
    }

    func testIsArticleURL() throws {
        for goodURL in yeses {
            XCTAssertTrue(
                goodURL.isArticleURL,
                "\(goodURL.relativeString) IS an article URL but was misclassified as a non-article URL."
            )
        }

        for invalidArticle in invalidArticles {
            XCTAssertFalse(
                invalidArticle.isArticleURL,
                "\(invalidArticle.relativeString) is NOT an article URL but was misclassified as an article URL."
            )
        }
    }
    func testID() throws {
        let testYeses = [
            URL(string: "https://skierscribbler.com/12151/ae/ferris-buellers-day-off/")!: 12151,
            URL(string: "https://skierscribbler.com/12259/news/kickoff-to-the-fall-season/")!: 12259,
            URL(string: "https://skierscribbler.com/12224/opinion/sonorities/")!: 12224,
            URL(string: "https://skierscribbler.com/1455/news/new-ahs-teacher-david-fregly/")!: 1455,
            URL(string: "https://skierscribbler.com/12008/showcase/spray-tan-booth-opening/")!: 12008
        ]

        for (url, id) in testYeses {
            XCTAssertEqual(url.id, id)
        }
        for invalidArticle in invalidArticles {
            // In the case that we are unable to determine an ID, we have an ID of zero.
            // FIXME: Should the `id` return a random number instead, so we don't run into multiple of the same IDs?
            XCTAssertEqual(invalidArticle.id, 0)
        }
    }

    func testCategory() throws {
        for invalidArticle in invalidArticles {
            XCTAssertEqual(
                invalidArticle.category, ArticleCategory.uncategorized,
                "A non-article URL was classified as other than uncategorized: \(invalidArticle.relativeString) was classified as \(invalidArticle.category)."
            )
        }

        let articles: [URL: ArticleCategory] = [
            URL(string: "https://skierscribbler.com/12151/ae/ferris-buellers-day-off/")!: .artsAndEntertainment,
            URL(string: "https://skierscribbler.com/12259/news/kickoff-to-the-fall-season/")!: .news,
            URL(string: "https://skierscribbler.com/12224/opinion/sonorities/")!: .opinion,
            URL(string: "https://skierscribbler.com/1455/news/new-ahs-teacher-david-fregly/")!: .news,
            URL(string: "https://skierscribbler.com/12008/showcase/spray-tan-booth-opening/")!: .showcase,
            URL(string: "https://skierscribbler.com/12019/uncategorized/satire-boys-history-month/")!: .uncategorized
        ]
        for article in articles {
            // `i` is a key-value pair of a URL to an ArticleCategory. 
            // We ensure that the category of the URL matches the statically defined one.
            XCTAssertEqual(
                article.key.category, article.value,
                "Category for '\(article.key.relativeString)' was '\(article.key.category)', but should have been '\(article.value)'."
            )
        }

    }

    func testIsSkierScribbler() {
        // Last URL is NOT a skierscribbler URL
        let validSkierScribblerURLs = invalidArticles.dropLast()
        let invalidSkierURL = invalidArticles.last

        for url in validSkierScribblerURLs {
            XCTAssertTrue(url.isSkierScribbler, "\(url.relativeString) misclassified.")
        }

        XCTAssertFalse(invalidSkierURL?.isSkierScribbler ?? false)

        for url in yeses {
            XCTAssert(url.isSkierScribbler)
        }

    }

}
