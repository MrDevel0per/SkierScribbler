//
//  URLHelper.swift
//  SkierScribblerTests
//
//  Created by Owen Cruz-Abrams on 11/2/23.
//

import Foundation
import XCTest

extension XCTestCase {
    // The docs are long, SwiftLint! They make sense.
    // swiftlint:disable line_length
    /// Assert that a given ``URL`` returns a valid, 200-range status code.
    /// - Note: All parameters except for `url` are optional and have somewhat verbose default values.
    /// - Parameters:
    ///   - url: The ``URL`` that will be requested and tested. This **must** be the URL of a **web page**, as local file URLs are not reachable via the network.
    ///   - errorMessage: The error message to be displayed in addition to the "URL:" and "ERROR:" at the end of the message. The default is "An error occured when fetching", and then the URL and ERROR are appended in the test.
    ///   - httpResponseFailureMessage: The error message to be displayed if the test fails to seralize the response of the URL to a ``HTTPResponse``. The default is "The response was not seralizeable to a HTTPURLResponse."
    ///   - not200ErrorMessage: The error message to be displayed if the response returns an error code that is not in the 200-299 (OK) range. The code and URL will be appended to the end of the error message. Default value: "A response that was not in the 200 range was encountered when trying to request data from"
    ///   - dataErrorMessage: The error message to be displayed if the ``Data`` of the response were not able to be converted to a String using the given encoding, default being UTF-8. The default is: "The response Data could not be converted to a String."
    ///   - encoding: The ``String.Encoding`` to be used to convert the data of the URL to a valid ``String``. Default value: UTF-8, the most common encoding in the world today.
    func XCTestURL(
        url: URL,
        errorMessage: String = "An error occured when fetching",
        httpResponseFailureMessage: String = "The response was not seralizeable to a HTTPURLResponse.",
        not200ErrorMessage: String = "A response that was not in the 200 range was encountered when trying to request data from",
        dataErrorMessage: String = "The response Data could not be converted to a String.",
        encoding: String.Encoding = .utf8
    ) throws {
        // swiftlint:enable line_length
        let expectation = self.expectation(description: "Completed fetch.")
        let session = URLSession.shared
        DispatchQueue(label: "Background test", qos: .userInitiated).async {
            session.dataTask(with: url) {data, response, error in
                if let error = error {
                    XCTFail(errorMessage + "URL: \(url.relativeString), ERROR: \(error.localizedDescription)")
                    return
                }
                // Convert the URL response to a HTTPURLResponse
                guard let HTTPResponse = response as? HTTPURLResponse else {
                    XCTFail(httpResponseFailureMessage)
                    return
                }
                // Just b/c the status code is good doesn't mean we didn't get a 404 page.
                XCTAssertTrue((200...299).contains(
                    HTTPResponse.statusCode),
                              not200ErrorMessage +
                              "URL: \(url.relativeString), RESPONSE CODE: \(HTTPResponse.statusCode)"
                )
                guard let responseAsString = String(data: data ?? Data(), encoding: encoding) else {
                    XCTFail(dataErrorMessage)
                    return
                }
                // Unnecessary - response code will already be 404.
                XCTAssertFalse(responseAsString.contains("The URL \(url) was Not Found, Error 404."))
                expectation.fulfill()
            }.resume()
        }
        self.wait(for: [expectation])
    }

}
