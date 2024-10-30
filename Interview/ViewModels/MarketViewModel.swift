//
//  MarketViewModel.swift
//  Interview
//
//  Created by Brian on 30/10/2024.
//  Copyright © 2024 AJBell. All rights reserved.
//


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
            var resultMarkets = [Market]()
            if let data = data,
               let result = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let marketsData = result["data"] as? [[String: Any]] {
                marketsData.forEach {
                    let market = Market(
                        name: $0["CompanyName"] as? String ?? "",
                        epic: $0["Epic"] as? String ?? "",
                        price: $0["CurrentPrice"] as? String ?? ""
                    )
                    resultMarkets.append(market)
                }
                
                self.markets = resultMarkets
                DispatchQueue.main.async {
                    self.reloadTableView?() 
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
