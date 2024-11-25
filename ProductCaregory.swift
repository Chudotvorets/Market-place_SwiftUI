//
//  ProductCaregory.swift
//  Market place
//
//  Created by dev on 19.11.2024.
//

import Foundation

enum ProductCategory: String, CaseIterable {
    case all = "All"
    case jewelery = "Jewelery"
    case electronics = "electronics"
    case men = "men's clothing"
    case women = "women's clothing"
    
    var path: String {
        
        switch self {
        case .all:
            return "/"
        case .jewelery:
            return "/category/jewelery"
        case .electronics:
            return "/category/electronics"
        case .men:
            return "/category/men%27s%20clothing"
        case .women:
            return "/category/women%27s%20clothing" 
        }
    }
    
    
    var displayName: String {
        switch self {
        case .all: return "Все товары"
        case .jewelery: return "Ювелирные изделия"
        case .electronics: return "Электроника"
        case .men: return "Мужская одежда"
        case .women: return "Женская одежда"
            
        }
    }
}
