//
//  ProductModel.swift
//  Market place
//
//  Created by dev on 14.11.2024.
//

import Foundation

struct Product: Identifiable, Codable, Hashable {
    var id: Int
    var title: String
    var price: Double
    var description: String
    var image: String
    
    var imageURL: URL? {
        URL(string: image)
    }
}
