//
//  NetworkManager.swift
//  Interview
//
//  Created by Brian on 30/10/2024.
//  Copyright © 2024 AJBell. All rights reserved.
//


import Foundation

class NetworkManager {
    
    static let shared = NetworkManager() 
    init() {}
    
    func fetchMarkets(completion: @escaping (Result<[Market], Error>) -> Void) {
        let urlString = "http://localhost:8080/api/general/money-am-quote-delayed?ticker=UKX,MCX,NMX,ASX,SMX,AIM1,IXIC,INDU,DEX."
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("Mock", forHTTPHeaderField: "Client")
        
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [NetworkInterceptor.self]
        let session = URLSession(configuration: configuration)
        
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(MarketResponse.self, from: data)
                completion(.success(decodedResponse.data))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    enum NetworkError: Error {
        case invalidURL
        case noData
    }
}
