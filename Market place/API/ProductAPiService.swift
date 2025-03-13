//
//  ProductService.swift
//  Market place
//
//  Created by dev on 14.11.2024.
//

import Foundation
import Moya

@MainActor
class APIService: ObservableObject {
    private let provider = MoyaProvider<ProductService>()
    
    func fetchProductsByCategory(category: ProductCategory) async throws -> String {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.fetchProductsByCategory(category: category)) { result in
                switch result {
                case .success(let response):
                    let responseString = String(data: response.data, encoding: .utf8) ?? "Failed to parse"
                    continuation.resume(returning: responseString)
                case .failure(let error):
                    let apiError = handleMoyaError(error)
                    continuation.resume(throwing: apiError)
                }
            }
        }
    }
    
    func fetchUser() async throws -> String {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.fetchUser) { result in
                switch result {
                case .success(let response):
                    let responseString = String(data: response.data, encoding: .utf8) ?? "Failed to parse"
                    continuation.resume(returning: responseString)
                case .failure(let error):
                    let apiError = handleMoyaError(error)
                    continuation.resume(throwing: apiError)
                }
            }
        }
    }
}





