//  Copyright © 2020 Matthew Dias. All rights reserved.

import XCTest

@testable import ImageMarkup

class APITests: XCTestCase {

    func test_Url() {
        let output = URL(string: "https://www.gravatar.com/avatar/6efb64b3947805fb42a761fbcca35b00?s=500")!
        XCTAssertEqual(API.image(output).url(), output)
    }
    
    
}
