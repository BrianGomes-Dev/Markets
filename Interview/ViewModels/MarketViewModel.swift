//
//  MarketViewModel.swift
//  Interview
//
//  Created by Brian on 30/10/2024.
//  Copyright © 2024 AJBell. All rights reserved.
//

import UIKit

public class MarketViewModel {
    var markets: [Market] = []
    var filteredMarkets: [Market] = []
    var reloadTableView: (() -> Void)?
    private var searchWorkItem: DispatchWorkItem?
    
    func loadMarkets() {
        NetworkManager.shared.fetchMarkets { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let markets):
                self.markets = markets
                self.filteredMarkets = markets
                
                DispatchQueue.main.async {
                    self.reloadTableView?()
                }
                
            case .failure(let error):
                print("Failed to fetch markets:", error)
            }
        }
    }
    
    func market(for indexPath: IndexPath, isFiltering: Bool) -> Market {
        return isFiltering ? filteredMarkets[indexPath.row] : markets[indexPath.row]
    }

    func numberOfMarkets(isFiltering: Bool) -> Int {
        return isFiltering ? filteredMarkets.count : markets.count
    }
    
    func filterMarkets(with query: String?) {
        searchWorkItem?.cancel()
        
        let workItem = DispatchWorkItem { [weak self] in
            guard let self = self, let query = query, !query.isEmpty else {
                self?.filteredMarkets = self?.markets ?? []
                self?.reloadTableView?()
                return
            }
            
            self.filteredMarkets = self.markets.filter {
                $0.name.lowercased().contains(query.lowercased())
            }
            
            DispatchQueue.main.async {
                self.reloadTableView?()
            }
        }
        
        searchWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: workItem)
    }
}
