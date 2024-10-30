//
//  InterviewTests.swift
//  InterviewTests
//
//  Created by Tiago on 04/04/2019.
//  Copyright © 2019 AJBell. All rights reserved.
//

import XCTest
@testable import Interview

class MarketViewModelTests: XCTestCase {
    var viewModel: MarketViewModel!

    override func setUp() {
        super.setUp()
        viewModel = MarketViewModel()
    }

    func testMarketLoading() {
        let expectation = XCTestExpectation(description: "Load markets data")
        
        viewModel.reloadTableView = {
            expectation.fulfill()
        }
        
        viewModel.loadMarkets()
        
        wait(for: [expectation], timeout: 5.0)
        XCTAssertEqual(viewModel.numberOfMarkets(), 9) // Change 10 to the expected number of mock entries
    }
}
