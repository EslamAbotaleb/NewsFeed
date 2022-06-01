//
//  NewsFeedTests.swift
//  NewsFeedTests
//
//  Created by Eslam Abotaleb on 01/06/2022.
//

import XCTest

class NewsFeedTests: XCTestCase {
    
    var networkClient: NetworkClient!
    var mockSession: MockURLSession!

    override func tearDown() {
        networkClient = nil
        mockSession = nil
        super.tearDown()
    }
    
    func testNetworkClient_successResult() {
        mockSession = MockSessionApi().createMockSession(fromJsonFile: "NewsFeed", andStatusCode: 200, andError: nil)
        networkClient = NetworkClient(withSession: mockSession)
        
        networkClient.showNewsFeed(url: URL(string: "https://saurav.tech/NewsAPI/everything/cnn.json")!) { (newsFeed, errorMessage) in

            XCTAssertNotNil(newsFeed)
            XCTAssertNil(errorMessage)

            XCTAssertTrue(newsFeed?.articles?.count == 99)

            let article = newsFeed!.articles?.first!
//            XCTAssertTrue(article?.source.id == "cbc")
            XCTAssertTrue(article?.source.id == "cnn")
           
        }
    }

}
