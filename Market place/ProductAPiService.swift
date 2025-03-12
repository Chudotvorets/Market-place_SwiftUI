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

enum ProductService {
    case fetchProductsByCategory(category: ProductCategory)
    case fetchUser
}

extension ProductService: TargetType {
    
    var baseURL: URL {
        switch self {
        case .fetchProductsByCategory:
            return URL(string: "https://fakestoreapi.com/products")!
        case .fetchUser:
            return URL(string: "https://randomuser.me/api/")!
        }
    }
    
    var path: String {
        switch self {
        case .fetchProductsByCategory(let category):
            return category.path
        case .fetchUser:
            return "" // randomuser.me/api/ не требует доп. пути
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}

// MARK: - Обработчик ошибок
func handleMoyaError(_ error: MoyaError) -> APICallError {
    switch error {
    case .underlying(let nsError as NSError, _):
        if nsError.code == NSURLErrorNotConnectedToInternet {
            return .apiError
        }
    case .statusCode(let response):
        if !(200...299).contains(response.statusCode) {
            return .invalidResponse
        }
    case .jsonMapping, .objectMapping:
        return .decodingError
    default:
        break
    }
    return .apiError
}

