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

    private enum CodingKeys: String, CodingKey {
        case epic = "Epic"
        case name = "CompanyName"
        case price = "CurrentPrice"
    }
}

struct MarketResponse: Codable {
    let data: [Market]
}
