//
//  MarketsTableViewController.swift
//  Interview
//
//  Created by Brian on 30/10/2024.
//  Copyright © 2024 AJBell. All rights reserved.
//

import UIKit

class MarketsTableViewController: UITableViewController, UISearchResultsUpdating {
    
    private var viewModel = MarketViewModel()
    private var dataSource: UITableViewDiffableDataSource<Section, Market>?
    private var searchController = UISearchController(searchResultsController: nil)
    private var filteredMarkets: [Market] = []
    private var searchWorkItem: DispatchWorkItem?
    
    enum Section {
        case main
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchController()
        configureDataSource()
        
        viewModel.reloadTableView = { [weak self] in
            self?.applySnapshot()
        }
        
        viewModel.loadMarkets()
    }
    
    private func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Markets"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, Market>(tableView: tableView) { tableView, indexPath, market in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
            
            cell.textLabel?.text = "\(market.epic) \(market.name)"
            cell.detailTextLabel?.text = market.price
            
            return cell
        }
    }
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Market>()
        snapshot.appendSections([.main])
        
        let marketsToDisplay = isFiltering() ? filteredMarkets : viewModel.markets
        snapshot.appendItems(marketsToDisplay)
        
        if let dataSource = dataSource {
            dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    private func isFiltering() -> Bool {
        return searchController.isActive && !(searchController.searchBar.text?.isEmpty ?? true)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        searchWorkItem?.cancel()
        
        let workItem = DispatchWorkItem { [weak self] in
            guard let self = self else { return }
            guard let searchText = searchController.searchBar.text?.lowercased(), !searchText.isEmpty else {
                self.filteredMarkets = self.viewModel.markets
                self.applySnapshot()
                return
            }
            
            self.filteredMarkets = self.viewModel.markets.filter { market in
                market.name.lowercased().contains(searchText)
            }
            
            self.applySnapshot()
        }
        
        searchWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: workItem)
    }
}
