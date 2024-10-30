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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.reloadTableView = { [weak self] in
            self?.tableView.reloadData()
        }
        
        viewModel.loadMarkets()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfMarkets()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let market = viewModel.market(for: indexPath)
        cell.textLabel?.text = "\(market.epic) \(market.name)"
        cell.detailTextLabel?.text = market.price
        return cell
    }
}
