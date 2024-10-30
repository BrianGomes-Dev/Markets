//
//  MarketViewModel.swift
//  Interview
//
//  Created by Brian on 30/10/2024.
//  Copyright © 2024 AJBell. All rights reserved.
//


import UIKit

import Foundation
import UIKit

public class MarketViewModel {
    var markets: [Market] = []
    var reloadTableView: (() -> Void)?

    func loadMarkets() {
        let url = "http://localhost:8080/api/general/money-am-quote-delayed?ticker=UKX,MCX,NMX,ASX,SMX,AIM1,IXIC,INDU,DEX."
        var request = URLRequest(url: URL(string: url)!)
        request.addValue("Mock", forHTTPHeaderField: "Client")

        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [NetworkInterceptor.self]
        let defaultSession = URLSession(configuration: configuration)

        defaultSession.dataTask(with: request) { [weak self] (data, response, error) in
            guard let self = self else { return }

            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(MarketResponse.self, from: data)
                    self.markets = decodedResponse.data
                    
                    DispatchQueue.main.async {
                        self.reloadTableView?()
                    }
                } catch {
                    print("Failed to decode JSON:", error)
                }
            }
        }.resume()
    }

    func market(for indexPath: IndexPath) -> Market {
        return markets[indexPath.row]
    }

    func numberOfMarkets() -> Int {
        return markets.count
    }
}
