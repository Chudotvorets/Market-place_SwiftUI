//
//  APIErrror.swift
//  MarketPlace
//
//  Created by dev on 12/03/2025.
//

import Foundation

enum APICallError: Error, CustomNSError {
    case apiError
    case invalidEndpoint
    case noData
    case invalidResponse
    case decodingError
    
    var localizedDescription: String {
        switch self {
        case .apiError: return "Failed to fetch data"
        case .invalidEndpoint: return "Invalid endpoint"
        case .invalidResponse: return "Invalid response"
        case .noData: return "No data"
        case .decodingError: return "Failed to decode data"
        }
    }
}
