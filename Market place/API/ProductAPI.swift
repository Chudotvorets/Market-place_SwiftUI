//
//  ProductAPI.swift
//  MarketPlace
//
//  Created by dev on 12/03/2025.
//

import Foundation
import Moya

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
