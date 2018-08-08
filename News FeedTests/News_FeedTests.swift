//
//  News_FeedTests.swift
//  News FeedTests
//
//  Created by Jason Howk on 8/7/18.
//  Copyright © 2018 Rude Tie, LLC. All rights reserved.
//

import XCTest
@testable import News_Feed

class News_FeedTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testNewsAPIService() {
        print("Testing Top Headlines...")
        // TODO: This could be improved by refactoring the Service to all for a mock response to be injected.  Keeping it simple for now.
        let expectation = XCTestExpectation(description: "top headlines")
        let api = NewsAPIService(withKey: "0f7cae49ce404bebaafbe47332970a4c")
        api.requestTopHeadlines { (result) in
            switch result {
            case .success(let response):
                print("Parsed Results: \(response)")
                XCTAssertTrue(response.articles.count == response.totalResults)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
}
