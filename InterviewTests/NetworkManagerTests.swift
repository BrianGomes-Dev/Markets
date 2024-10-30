//
//  NetworkManagerTests.swift
//  Interview
//
//  Created by Brian on 30/10/2024.
//  Copyright © 2024 AJBell. All rights reserved.
//


import XCTest
@testable import Interview

class NetworkManagerTests: XCTestCase {
    
    func testFetchMarketsSuccess() {
        let expectation = XCTestExpectation(description: "Markets data fetched and decoded")
        
        NetworkManager.shared.fetchMarkets { result in
            switch result {
            case .success(let markets):
                XCTAssertFalse(markets.isEmpty)
                XCTAssertEqual(markets.first?.name, "FTSE 100")
                expectation.fulfill()
            case .failure:
                XCTFail("Expected success, got failure")
            }
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
}
