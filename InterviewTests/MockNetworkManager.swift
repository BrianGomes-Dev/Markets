//
//  MockNetworkManager.swift
//  Interview
//
//  Created by Brian on 30/10/2024.
//  Copyright © 2024 AJBell. All rights reserved.
//


import Foundation
@testable import Interview

class MockNetworkManager: NetworkManager {
    var shouldReturnError = false
    
    override func fetchMarkets(completion: @escaping (Result<[Market], Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NetworkManager.NetworkError.noData))
        } else {
            let mockMarkets = [
                Market(epic: "FTSE:UKX", name: "FTSE 100", price: "7000", midPrice: "6900", highTradePrice: "7100", lowTradePrice: "6800", currency: "GBP"),
                Market(epic: "FTSE:MCX", name: "FTSE Mid 250", price: "20000", midPrice: "19900", highTradePrice: "20200", lowTradePrice: "19800", currency: "GBP"),
                Market(epic: "XNAS:@CCO", name: "NASDAQ Composite", price: "13000", midPrice: "12900", highTradePrice: "13100", lowTradePrice: "12800", currency: "USD")
            ]
            completion(.success(mockMarkets))
        }
    }
}
