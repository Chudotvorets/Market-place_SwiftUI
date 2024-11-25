//
//  ProductService.swift
//  Market place
//
//  Created by dev on 14.11.2024.
//

import Foundation
import Moya

enum ProductService {
    case fetchProductsByCategory(category: ProductCategory)
}

extension ProductService: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://fakestoreapi.com/products")!
    }
    var path: String {
        switch self {
        case .fetchProductsByCategory(category: let category):
            let path = category.path
            return path
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
