//
//  MarketDetailViewController.swift
//  Interview
//
//  Created by Brian on 30/10/2024.
//  Copyright © 2024 AJBell. All rights reserved.
//


import UIKit

class MarketDetailViewController: UIViewController {
    
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var currentPriceLabel: UILabel!
    @IBOutlet weak var tradeHighLabel: UILabel!
    @IBOutlet weak var tradeLowLabel: UILabel!
    
    var market: Market?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let market = market else {
            return
        }
        
        companyNameLabel.text = market.name
        currentPriceLabel.text = "\(market.currency) \(market.price)"
        tradeHighLabel.text = "\(market.currency) \(market.highTradePrice)"
        tradeLowLabel.text = "\(market.currency) \(market.lowTradePrice)"
        
        setupAccessibility(for: market)
    }
    
    private func setupAccessibility(for market: Market) {
        companyNameLabel.isAccessibilityElement = true
        companyNameLabel.accessibilityLabel = "Company Name"
        companyNameLabel.accessibilityValue = market.name
        companyNameLabel.accessibilityIdentifier = "companyNameLabel"
        
        currentPriceLabel.isAccessibilityElement = true
        currentPriceLabel.accessibilityLabel = "Current Price"
        currentPriceLabel.accessibilityValue = "\(market.currency) \(market.price)"
        currentPriceLabel.accessibilityIdentifier = "currentPriceLabel"
        
        tradeHighLabel.isAccessibilityElement = true
        tradeHighLabel.accessibilityLabel = "High Trade Price"
        tradeHighLabel.accessibilityValue = "\(market.currency) \(market.highTradePrice)"
        tradeHighLabel.accessibilityIdentifier = "tradeHighLabel"
        
        tradeLowLabel.isAccessibilityElement = true
        tradeLowLabel.accessibilityLabel = "Low Trade Price"
        tradeLowLabel.accessibilityValue = "\(market.currency) \(market.lowTradePrice)"
        tradeLowLabel.accessibilityIdentifier = "tradeLowLabel"
    }
}
