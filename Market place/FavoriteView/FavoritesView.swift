//
//  FavoritesView.swift
//  MarketPlace
//
//  Created by dev on 28.11.2024.
//

import Foundation
import SwiftUI

struct FavoritesView: View {
    
    @EnvironmentObject var viewModel: ProductViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(viewModel.products) { product in
                            if viewModel.isFavorite(product) {
                                NavigationLink(destination: ProductDetailView(product: product)) {
                                    ProductCardView(product: product)
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Favorites")
            }
        }
    }
}
