//
//  UrlTest.swift
//  iosChallengeTests
//
//  Created by puyue on R 3/08/30.
//

@testable import iosChallenge
import XCTest

class UrlTest: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    func test_url() {
        XCTAssertEqual(GlobalUrl.get_all_rate_base_USD, "http://api.currencylayer.com/live?access_key=f6fbf49394a6f17e75e64ef2662a89b6&source=USD")
    }

}
