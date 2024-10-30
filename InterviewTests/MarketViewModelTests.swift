//
//  MarketViewModelTests.swift
//  Interview
//
//  Created by Brian on 30/10/2024.
//  Copyright © 2024 AJBell. All rights reserved.
//


import XCTest
@testable import Interview

class MarketViewModelTests: XCTestCase {
    var viewModel: MarketViewModel!
    var mockNetworkManager: MockNetworkManager!
    
    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        viewModel = MarketViewModel(networkmanager: MockNetworkManager())
    }
    
    override func tearDown() {
        viewModel = nil
        mockNetworkManager = nil
        super.tearDown()
    }
    
    func testLoadMarketsSuccess() {
        let expectation = XCTestExpectation(description: "Markets loaded")
        viewModel.reloadTableView = {
            XCTAssertEqual(self.viewModel.markets.count, 3) 
            XCTAssertFalse(self.viewModel.markets.isEmpty)
            expectation.fulfill()
        }
        
        mockNetworkManager.shouldReturnError = false
        viewModel.loadMarkets()
        
        wait(for: [expectation], timeout: 2.0)
    }
}
