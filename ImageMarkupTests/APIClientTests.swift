//
//  APIClientTests.swift
//  ImageMarkupTests
//
//  Created by Matthew Dias on 9/5/20.
//  Copyright © 2020 Matthew Dias. All rights reserved.
//

import XCTest
import Combine

@testable import ImageMarkup

class APIClientTests: XCTestCase {
    
    var cancellables: Set<AnyCancellable> = []

    func test_get_returnsError_forTimeout() {
        let url = URL(string: "https://not_a_real_url.com")
        let client = APIClient()

        let exp = expectation(description: "network request")
        var result: Error?

        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 0.1

        client.get(url!, session: URLSession(configuration: sessionConfig))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    result = error
                case .finished: break
                }
                exp.fulfill()
            }, receiveValue: { _ in
                XCTFail("we should never receive a value")
            })
            .store(in: &cancellables)

        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertNotNil(result)
    }
    
    func test_get_returnsImage() throws {
        let url = API.subreddit.url()
        let client = APIClient()
        
        let exp = expectation(description: "network request")
        var result: UIImage?
        
        client.get(url)
            .decode(type: Response.self, decoder: JSONDecoder())
            .compactMap { $0.data.children.map(\.data).first(where: { child in child.postHint == .image })?.url }
            .flatMap { url in client.get(url) }
            .map(UIImage.init(data:))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    XCTFail("Unexpected error: \(error)")
                case .finished: break
                }
                exp.fulfill()
            }, receiveValue: { image in
                result = image
            })
            .store(in: &cancellables)

        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(result)
        XCTAssertNotEqual(result, UIImage())
    }

}

