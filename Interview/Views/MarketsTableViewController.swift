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
        
        let isFiltering = isFilteringActive()
        snapshot.appendItems(isFiltering ? viewModel.filteredMarkets : viewModel.markets)
        
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    private func isFilteringActive() -> Bool {
        return searchController.isActive && !(searchController.searchBar.text?.isEmpty ?? true)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.filterMarkets(with: searchController.searchBar.text)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMarketDetail",
           let destinationVC = segue.destination as? MarketDetailViewController,
           let selectedMarket = sender as? Market {
            destinationVC.market = selectedMarket
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let isFiltering = isFilteringActive()
        let selectedMarket = viewModel.market(for: indexPath, isFiltering: isFiltering)
        
        performSegue(withIdentifier: "showMarketDetail", sender: selectedMarket)
    }
}
