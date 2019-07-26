//
//  ShazamTests.swift
//  ShazamTests
//
//  Created by Medi Assumani on 3/16/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import XCTest
@testable import Shazam

class ShazamTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let downloader = Shazam(withUrlString: <#T##String#>)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
