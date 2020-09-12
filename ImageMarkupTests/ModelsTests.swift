//
//  ModelsTests.swift
//  ImageMarkupTests
//
//  Created by Matthew Dias on 9/12/20.
//  Copyright © 2020 Matthew Dias. All rights reserved.
//

import XCTest

@testable import ImageMarkup

class ModelsTests: XCTestCase {
    
    func test_getImageURLs() {
        let sut = Response(data: ResponseData(children: [
            Child(data: ChildData(postHint: .link, url: URL(string: "http://some_link.com")!)),
            Child(data: ChildData(postHint: .image, url: URL(string: "http://image1.com")!)),
            Child(data: ChildData(postHint: .richVideo, url: URL(string: "http://richVideo.com")!)),
            Child(data: ChildData(postHint: .image, url: URL(string: "http://image2.com")!)),
            Child(data: ChildData(postHint: .image, url: URL(string: "http://image3.com")!)),
        ]))
        
        let expected = [
            URL(string: "http://image1.com")!,
            URL(string: "http://image2.com")!,
        ]
        
        XCTAssertEqual(sut.imageUrls, expected)
    }
    
}
