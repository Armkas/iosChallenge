//
//  StringTest.swift
//  iosChallengeTests
//
//  Created by puyue on R 3/08/30.
//

@testable import iosChallenge
import XCTest

class StringTest: XCTestCase {

    override func setUp() {
        super.setUp()

    }
    
    override func tearDown() {

        super.tearDown()
    }
    
    func testChangeString() {
        let str = "USDJPY"
        XCTAssertEqual(str.subString(from: 3) , "JPY")
    }
}
