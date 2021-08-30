//
//  DataTests.swift
//  iosChallengeTests
//
//  Created by puyue on R 3/08/30.
//

@testable import iosChallenge
import XCTest

class DataTests: XCTestCase {
    
    var save: [String : Double]!
        
    override func setUp() {
        super.setUp()
        save = GlobalData.quotes
        GlobalData.quotes = ["USDNOK":8.68096]
        
    }
    
    override func tearDown() {
        GlobalData.quotes = save
        super.tearDown()
    }
    
    func test_currencies() {
        XCTAssertEqual(GlobalData.currencies, ["NOK"])
    }
    
    func test_rates() {
        XCTAssertEqual(GlobalData.rates, [8.68096])
    }

}
