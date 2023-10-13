//
//  APIClientTests.swift
//  SkierScribblerTests
//
//  Created by Owen Cruz-Abrams on 10/7/23.
//

import XCTest
import SwiftSoup

@testable import SkierScribbler

final class APIClientTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //MARK: - Fetch tests
    func test404Fetch() async throws {
        await XCAssertThrowsAsyncError(try await APIClient.shared.fetchPage(at: URL(string: "https://thiswontwork.org/404page")!), "For an unknown reason, fetching a non-existent page https://thiswontwork.org/404page did not throw an error.")
        
        // Ensure there's a 404 when getting a nonexistent skierscribbler page as well
        await XCAssertThrowsAsyncError(try await APIClient.shared.fetchPage(at: URL(string: "https://skierscribbler.com/100")!)) { error in
            XCTAssertEqual(error as? APIClient.ClientError, APIClient.ClientError.fetchError(404))
        }
    }
    
    func testNoErrorFetch() async throws {
        let document = try await APIClient.shared.fetchPage(at: URL(string: "https://skierscribbler.com/12151/ae/ferris-buellers-day-off/")!)
        XCTAssertFalse(try document.getAllElements().isEmpty())
    }
    

}
