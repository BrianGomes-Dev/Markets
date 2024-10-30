//
//  MarketsTableViewController.swift
//  Interview
//
//  Created by Brian on 30/10/2024.
//  Copyright © 2024 AJBell. All rights reserved.
//

import UIKit

class MarketsTableViewController: UITableViewController {
    
    private var viewModel = MarketViewModel()
    private var dataSource: UITableViewDiffableDataSource<Section, Market>?
    
    enum Section {
        case main
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDataSource()
        
        viewModel.reloadTableView = { [weak self] in
            self?.applySnapshot()
        }
        
        viewModel.loadMarkets()
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
        snapshot.appendItems(viewModel.markets)
        
        if let dataSource = dataSource {
            dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}
