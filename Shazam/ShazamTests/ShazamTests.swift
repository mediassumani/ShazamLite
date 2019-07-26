//
//  ShazamTests.swift
//  ShazamTests
//
//  Created by Medi Assumani on 3/16/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import XCTest
@testable import Shazam


struct Todo: Codable {
    
    var userId: Int?
    var title: String?
    var completed: Bool?
}

class ShazamTests: XCTestCase {

    var downloader: Shazam!
    var todo: Todo!
    
    
    override func setUp() {
        
        downloader = Shazam(withUrlString: "https://jsonplaceholder.typicode.com/posts/1")
        todo = Todo(userId: 1, title: "Get Food from work", completed: true)
    }

    /// Test that we can decode a JSON object with Dictionary
    func testGetWithouDictJSON() {
        
        let getDataExpectation = XCTestExpectation(description: "tests the get method of Shazam class")
        
        downloader.get(parameters: nil, headers: nil) { (result: Result<[Todo]?, Error>) in
            
            switch result{
            case let .success(data):
                getDataExpectation.fulfill()
                
            case .failure(_):
                print("failed")
            }
            
            self.wait(for: [getDataExpectation], timeout: 10.0)
        }
    }
    
    
    func testGetWithArrayJSON() {
     
//        let getDataExpectation = XCTestExpectation(description: "tests the get method of Shazam class")
//        downloader.urlString =
//        downloader.get(parameters: nil, headers: nil) { (result: Result<[Todo]?, Error>) in
//
//            switch result{
//            case let .success(data):
//                // Make sure that the data is of type Todo
//                XCTAssertTrue(type(of: data) == Todo.self)
//                getDataExpectation.fulfill()
//
//            case .failure(_):
//                print("failed")
//            }
//        }
    }
    
    func testSetWithPost() {
    
    }
    
    func testSetWithPut() {
        
    }
    
    func testSetWithDelete() {
        
    }
    
    
    override func tearDown() {
        
    }
    
    
}
