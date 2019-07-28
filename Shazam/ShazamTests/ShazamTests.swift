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
    func testGetWithDictJSON() {
        
        let getDataExpectation = XCTestExpectation(description: "tests the get method of Shazam class")
        
        XCTAssertNotNil(downloader)
        XCTAssertNotNil(todo)
        
        downloader.get(parameters: nil, headers: nil) { (result: Result<Todo?, Error>) in
            
            XCTAssertNotNil(result)
            
            switch result{
            case let .success(data):

                XCTAssertNotNil(data)
                XCTAssertTrue(type(of: data) == Todo?.self)
                XCTAssertTrue(type(of: data?.completed) == Bool?.self)
                XCTAssertTrue(type(of: data?.title) ==  String?.self)
                XCTAssertTrue(type(of: data?.userId) ==  Int?.self)
                
            case let .failure(error):
                XCTAssertNil(error)
            }
            
            getDataExpectation.fulfill()
        }
        wait(for: [getDataExpectation], timeout: 5)
    }
    
    
    func testGetWithArrayJSON() {
     
        let getDataExpectation = XCTestExpectation(description: "tests the get method of Shazam class")
        
        XCTAssertNotNil(downloader)
        XCTAssertNotNil(todo)
        downloader.urlString = "https://jsonplaceholder.typicode.com/posts"
        
        downloader.get(parameters: nil, headers: nil) { (result: Result<[Todo]?, Error>) in
            
            XCTAssertNotNil(result)
            
            switch result{
            case let .success(data):
                
                XCTAssertNotNil(data)
                XCTAssertTrue(type(of: data) == [Todo]?.self)
                XCTAssertTrue(data!.count > 1)
                
            case let .failure(error):
                
                XCTAssertNil(error)
            }
            
            getDataExpectation.fulfill()
        }
        wait(for: [getDataExpectation], timeout: 5)
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
