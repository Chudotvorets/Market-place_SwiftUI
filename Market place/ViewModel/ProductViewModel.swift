//
//  ProductViewModel.swift
//  Market place
//
//  Created by dev on 14.11.2024.
//

import Foundation
import Moya
import Combine
import CombineMoya
import SwiftUI

@MainActor
class ProductViewModel: ObservableObject {
    
    @Published var products: [Product] = []
    @Published var searchQuery: String = ""
    @Published var isLoading: Bool = false
    @Published var currentIndex = 0
    
    //private let provider = MoyaProvider<ProductService>()
    private let productService = APIServices()
    private let favoritesService: FavoritesService
    private var cancellables = Set<AnyCancellable>()
    private var carouselTimer: AnyCancellable?
    
    init(favoritesService: FavoritesService) {
        self.favoritesService = favoritesService
        fetchProducts()
        startCarouselTimer()
        //setupAutoScroll()
    }
    
//    func handleDragGesture(_ gesture: DragGesture.Value, screenWidth: CGFloat) {
//            let dragThreshold: CGFloat =/Users/work2/Desktop/WorkProject/Market place/Market place/API/ProductAPiService.swift screenWidth / 2
//            if gesture.translation.width < -dragThreshold {
//                currentIndex = min(currentIndex + 1, products.count - 1)
//            } else if gesture.translation.width > dragThreshold {
//                currentIndex = max(currentIndex - 1, 0)
//            }
//        }
    
    private func setupAutoScroll() {
           Timer.publish(every: 3, on: .main, in: .common)
               .autoconnect()
               .sink { [weak self] _ in
                   guard let self = self else { return }
                   self.currentIndex = (self.currentIndex + 1) % self.products.count
               }
               .store(in: &cancellables)
        }
    
    func stopAutoScroll() {
            cancellables.removeAll()
        }

        func nextProduct() {
            currentIndex = (currentIndex + 1) % products.count
        }

        func previousProduct() {
            currentIndex = (currentIndex - 1 + products.count) % products.count
        }
    
    // MARK: - Перезагружаем список при изменении состояния избранного
    private func setupBindings() {
        favoritesService.$favoriteProducts
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
    }

    //MARK: - Проверка, является ли товар избранным
    func isFavorite(_ product: Product) -> Bool {
            favoritesService.isFavorite(product.id)
        }

    //MARK: - Переключение статуса избранного
    func toggleFavorite(for product: Product) {
            if isFavorite(product) {
                favoritesService.removeFromFavorites(product.id)
            } else {
                favoritesService.addToFavorites(product.id)
            }
        }
    
    func fetchProducts() {
  
        productService.fetchProducts(from: .all) { (result) in
            
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        //self.isLoading = true
                        self.products = response
                        print("init response")
                    }
                case .failure(let error):
                    print(error)
                
            }
        }
    }
    
    func startCarouselTimer() {
        carouselTimer = Timer.publish(every: 3, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                if !self.products.isEmpty {
                    self.currentIndex = (self.currentIndex + 1) % self.products.count
                }
            }
    }
    
    
    var filteredProducts: [Product] {
        if searchQuery.isEmpty {
            return products
        } else {
            return products.filter { $0.title.lowercased().contains(searchQuery.lowercased()) }
        }
    }
}
