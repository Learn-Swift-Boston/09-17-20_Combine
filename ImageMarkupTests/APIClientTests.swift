//
//  APIClientTests.swift
//  ImageMarkupTests
//
//  Created by Matthew Dias on 9/5/20.
//  Copyright © 2020 Matthew Dias. All rights reserved.
//

import XCTest
@testable import ImageMarkup
import Combine

class APIClientTests: XCTestCase {
    
    var cancellables: Set<AnyCancellable> = []

    func test_get_returnsEmptyImage_forBadURL() {
        let expected = UIImage()
        let url = URL(string: "https://google.com")
        let client = APIClient()
        
        let exp = expectation(description: "network request")
        var result: UIImage?
    
        
        let cancellable = client.get(url!)
            .sink(receiveCompletion: { _ in }, receiveValue: { image in
                result = image
                exp.fulfill()
            })
        
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertNotNil(cancellable)
        XCTAssertEqual(result, expected)
    }
    
    func test_get_returnsImage() throws {
        let imageData = try XCTUnwrap(Bundle(for: Self.self)
            .url(forResource: "zev_avatar", withExtension: nil)
            .map { try Data(contentsOf: $0) })
        let expected = UIImage(data: imageData)
        let url = URL(string: "https://www.gravatar.com/avatar/6efb64b3947805fb42a761fbcca35b00?s=500")
        let client = APIClient()
        
        let exp = expectation(description: "network request")
        var result: UIImage?
        
        let cancellable = client.get(url!)
            .sink(receiveCompletion: { _ in }, receiveValue: { image in
                result = image
                exp.fulfill()
            })
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(cancellable)
        assertEqualImages(result, expected)
    }

}

extension XCTestCase {
    func assertEqualImages(_ image1: UIImage?, _ image2: UIImage?, file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(image1?.pngData(), image2?.pngData(), file: file, line: line)
    }
}
