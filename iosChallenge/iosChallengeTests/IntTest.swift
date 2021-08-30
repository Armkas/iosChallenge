//
//  IntTest.swift
//  iosChallengeTests
//
//  Created by puyue on R 3/08/30.
//

@testable import iosChallenge
import XCTest

class IntTest: XCTestCase {
    
    override func setUp() {
        super.setUp()

    }
    
    override func tearDown() {

        super.tearDown()
    }
    
    func testChangeDate() {
        let time: Int = 1630324396
        XCTAssertEqual(time.toDateString(), "2021-08-30 11:53")
    }
    

}
