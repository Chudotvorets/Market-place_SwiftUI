//
//  ProductService.swift
//  Market place
//
//  Created by dev on 14.11.2024.
//

import Foundation
import Moya

protocol APIServicesProtocol {
    func fetchProducts(from endpoint: ProductCategory, completion: @escaping (Result<[Product], APICallError>) -> ())
    func fetchUser(completion: @escaping (Result<UserAPIResults, APICallError>) -> ())
}

class APIServices: APIServicesProtocol {
    
    
    
    private let provider = MoyaProvider<ProductService>()
        
        func fetchProducts(from endpoint: ProductCategory, completion: @escaping (Result<[Product], APICallError>) -> ()) {
            provider.request(.fetchProductsByCategory(category: endpoint)) { result in
                switch result {
                case .success(let response):
                    do {
                        let products = try JSONDecoder().decode([Product].self, from: response.data)
                        completion(.success(products))
                    } catch {
                        completion(.failure(.decodingError))
                    }
                case .failure(let error):
                    completion(.failure(handleMoyaError(error)))
                }
            }
        }
        
        
        func fetchUser(completion: @escaping (Result<UserAPIResults, APICallError>) -> ()) {
            provider.request(.fetchUser) { result in
                switch result {
                case .success(let response):
                    do {
                        let user = try JSONDecoder().decode(UserAPIResults.self, from: response.data)
                        completion(.success(user))
                    } catch {
                        completion(.failure(.decodingError))
                    }
                case .failure(let error):
                    completion(.failure(handleMoyaError(error)))
                
            }
        }
    }
}





