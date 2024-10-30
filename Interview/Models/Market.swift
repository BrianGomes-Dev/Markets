//
//  Market.swift
//  Interview
//
//  Created by Brian on 30/10/2024.
//  Copyright © 2024 AJBell. All rights reserved.
//

struct Market: Codable, Hashable {
    let epic: String
    let name: String
    let price: String
    let midPrice: String
    let highTradePrice: String
    let lowTradePrice: String
    let currency: String

    private enum CodingKeys: String, CodingKey {
        case epic = "Epic"
        case name = "CompanyName"
        case price = "CurrentPrice"
        case midPrice = "MidPrice"
        case highTradePrice = "HighTradePrice"
        case lowTradePrice = "LowTradePrice"
        case currency = "Currency"
    }
}


struct MarketResponse: Codable {
    let data: [Market]
}
