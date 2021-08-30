//
//  ApiServiceTest.swift
//  iosChallengeTests
//
//  Created by puyue on R 3/08/30.
//

@testable import iosChallenge
import XCTest

class ApiServiceTest: XCTestCase {
    
    var apiService: ApiService!
    
    override func setUp() {
        super.setUp()
        apiService = ApiService()
    }
    
    override func tearDown() {
        apiService = nil
        super.tearDown()
    }
    
    func test_fetchApiData_incorrectURL() {
        let urlString = "incorrectURL"
        apiService.fetchApiData(urlString: urlString) { (data, err)  in
            XCTAssertNotNil(err)
            XCTAssertNil(data)
        }
    }
    
    func test_fetchApiData() {
        let urlString = "http://api.currencylayer.com/live?access_key=f6fbf49394a6f17e75e64ef2662a89b6&source=USD"
        apiService.fetchApiData(urlString: urlString) { (data, err)  in
            XCTAssertNotNil(data)
            XCTAssertNil(err)
        }
    }

}
