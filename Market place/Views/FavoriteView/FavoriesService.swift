//
//  FavoriesService.swift
//  MarketPlace
//
//  Created by dev on 25.11.2024.
//

import Foundation
import Combine

final class FavoritesService {    //Actor sendable preconcurencyw
//    struct Trysi {
//        let id: Int?
//        let colors: [TrusiColor]
//    }
//    struct TrusiColor {
//        let color: String? //"Y"
//        let size: [Int]? //[15,16,20]
//    }
    
    @Published private(set) var favoriteProducts: Set<Int> = [] {
        //Доступен только для чтения за пределами класса. Изменять это свойство можно только внутри FavoritesService.
        didSet {
            saveFavorites()
        }
    }
    
    init() {
        loadFavorites()
    }
    
    //MARK: - Добавить товар в избранное
    func addToFavorites(_ productId: Int) {
        guard !favoriteProducts.contains(productId) else { return }
        favoriteProducts.insert(productId)
    }
    
    //MARK: - Удалить товар из избранного
    func removeFromFavorites(_ productId: Int) {
        favoriteProducts.remove(productId)
    }
    
    //MARK: - Проверить, является ли товар избранным
    func isFavorite(_ productId: Int) -> Bool {
        favoriteProducts.contains(productId)
    }
    //MARK: - Сохранить избранные товары в UserDefaults
    private func saveFavorites() {
        let defaults = UserDefaults.standard
        defaults.set(Array(favoriteProducts), forKey: "favoriteProducts")
    }
    //MARK: - Загрузить избранные товары из UserDefaults
    private func loadFavorites() {
        let defaults = UserDefaults.standard
        if let savedIDs = defaults.array(forKey: "favoriteProducts") as? [Int] {
            favoriteProducts = Set(savedIDs)
        }
    }
}
