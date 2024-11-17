//
//  ProductService.swift
//  Market place
//
//  Created by dev on 14.11.2024.
//

import Foundation
import Moya

enum ProductService {
    case fetchProductsByCategory
}

extension ProductService: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://fakestoreapi.com/products")!
    }
    var path: String {
        return ""
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
