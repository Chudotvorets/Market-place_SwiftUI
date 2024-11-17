//
//  ProductViewModel.swift
//  Market place
//
//  Created by dev on 14.11.2024.
//

import Foundation
import Moya
import Combine

class ProductViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var favorites: [Product] = []
    @Published var searchQuery: String = ""
    @Published var isLoading: Bool = false
    @Published var currentCarouselIndex: Int = 0
}
