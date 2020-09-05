//  Copyright © 2020 Matthew Dias. All rights reserved.

import XCTest

@testable import ImageMarkup

class APITests: XCTestCase {


    func test_hash_returnsString() {
        let input = "beau@dentedreality.com.au"
        let md5OfInput = "205e460b479e2e5b48aec07710c08d50"
        XCTAssertEqual(API.hash(email: input), md5OfInput)
    }
    
    func test_hash_trims() {
        let input = "   beau@dentedreality.com.au "
        let md5OfInput = "205e460b479e2e5b48aec07710c08d50"
        XCTAssertEqual(API.hash(email: input), md5OfInput)
    }
    
    func test_hash_case() {
        let input = "beau@dentEdreaLity.cOM.au"
        let md5OfInput = "205e460b479e2e5b48aec07710c08d50"
        XCTAssertEqual(API.hash(email: input), md5OfInput)
    }
    
    func test_Url() {
        let email = "zev@zeveisenberg.com"
        let output = URL(string: "https://www.gravatar.com/avatar/6efb64b3947805fb42a761fbcca35b00")
        XCTAssertEqual(API.gravatar(email: email).url(), output)
    }
}
