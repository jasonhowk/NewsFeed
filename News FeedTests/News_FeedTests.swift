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
        let expectation = XCTestExpectation(description: "top headlines")
        let api = NewsAPIService(withKey: "0f7cae49ce404bebaafbe47332970a4c")
        api.requestTopHeadlines { (apiResponse, result) in
            switch result {
            case .success:
                if let response = apiResponse {
                    print("Parsed Results: \(response)")
                    XCTAssertTrue(response.articles.count == response.totalResults)
                } else {
                    XCTFail("Successful result received, however received an empty response.")
                }
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
}
