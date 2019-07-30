//
//  ShazamTests.swift
//  ShazamTests
//
//  Created by Medi Assumani on 3/16/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import XCTest
@testable import ShazamLite


struct Todo: Codable {
    
    var userId: Int?
    var title: String?
    var completed: Bool?
}

class ShazamTests: XCTestCase {

    var downloader: Shazam!
    var todo: Todo!
    var encodedData: Data!
    var method: HTTPMethod!
    var getDataExpectation: XCTestExpectation!
    var setDataExpectation: XCTestExpectation!
    
    
    override func setUp() {
        
        downloader = Shazam(withUrlString: "https://jsonplaceholder.typicode.com/posts/1")
        todo = Todo(userId: 1, title: "Get Food from work", completed: true)
        encodedData = try! JSONEncoder().encode(todo)
        method = .post
        getDataExpectation = XCTestExpectation(description: "tests the async get method of Shazam class")
        setDataExpectation = XCTestExpectation(description: "tests the async set method of Shazam class")
    }

    /// Test that we can decode a JSON object with Dictionary
    func testGetWithDictJSON() {
        
        XCTAssertNotNil(downloader)
        XCTAssertNotNil(todo)
        
        downloader.set(parameters: nil, headers: nil, method: .post, body: <#T##Data?#>, completion: <#T##(Result<Bool, Error>) -> ()#>)
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
            
            self.getDataExpectation.fulfill()
        }
        wait(for: [getDataExpectation], timeout: 5)
    }
    
    
    func testGetWithArrayJSON() {
     
        getDataExpectation = XCTestExpectation(description: "Tests the get method of Shazam class")
        downloader.urlString = "https://jsonplaceholder.typicode.com/posts"
        
        XCTAssertNotNil(downloader)
        XCTAssertNotNil(todo)
        
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
            
            self.getDataExpectation.fulfill()
        }
        wait(for: [getDataExpectation], timeout: 5)
    }
    
    // Test the Post's HTTP Method
    func testSetWithPost() {
        
        XCTAssertNotNil(downloader)
        XCTAssertNotNil(todo)
        
        todo = Todo(userId: 1, title: "Test Post method", completed: true)
        downloader.urlString = "https://jsonplaceholder.typicode.com/posts"
        
        downloader.set(parameters: nil, headers: nil, method: method, body: encodedData) { (result: Result<Bool, Error>) in
            
            XCTAssertNotNil(result)
            switch result {
                
            case let .success(data):
                
                XCTAssertNotNil(data)
                XCTAssertTrue(data)
                
                self.setDataExpectation.fulfill()
                
            case let .failure(error):
                XCTAssertNil(error)
            }
        }
        
        
        wait(for: [setDataExpectation], timeout: 5)
    }
    
    // Test the Put's HTTP Method
    func testSetWithPut() {
        
        XCTAssertNotNil(downloader)
        XCTAssertNotNil(todo)
        
        todo = Todo(userId: 1, title: "Test Put method", completed: true)
        downloader.urlString = "https://jsonplaceholder.typicode.com/posts/1"
        method = .put
        
        downloader.set(parameters: nil, headers: nil, method: method, body: encodedData) { (result: Result<Bool, Error>) in
            
            XCTAssertNotNil(result)
            switch result {
                
            case let .success(data):
                
                XCTAssertNotNil(data)
                XCTAssertTrue(data)
                
                self.setDataExpectation.fulfill()
                
            case let .failure(error):
                XCTAssertNil(error)
            }
        }
        wait(for: [setDataExpectation], timeout: 5)
    }
    
    // Test the Delete's HTTP Method
    func testSetWithDelete() {
        
        XCTAssertNotNil(downloader)
        XCTAssertNotNil(todo)
        
        todo = Todo(userId: 1, title: "Test Delete method", completed: true)
        downloader.urlString = "https://jsonplaceholder.typicode.com/posts/1"
        method = .delete
        
        downloader.set(parameters: nil, headers: nil, method: method, body: encodedData) { (result: Result<Bool, Error>) in
            
            XCTAssertNotNil(result)
            switch result {
                
            case let .success(data):
                
                XCTAssertNotNil(data)
                XCTAssertTrue(data)
                
                self.setDataExpectation.fulfill()
                
            case let .failure(error):
                XCTAssertNil(error)
            }
        }
        wait(for: [setDataExpectation], timeout: 5)
    }
    
    override func tearDown() {
        
        todo = nil
        setDataExpectation = nil
        getDataExpectation = nil
        downloader = nil
        method = nil
        encodedData = nil
    }
}
