//
//  ProductListView.swift
//  Market place
//
//  Created by dev on 14.11.2024.
//

import Foundation
import SwiftUI
import Kingfisher

struct ProductListView: View {
    
    @EnvironmentObject var viewModel: ProductViewModel
    @State private var showCarousel = true
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $viewModel.searchQuery)
                
                if showCarousel, viewModel.products.indices.contains(viewModel.currentCarouselIndex) {
                    let currentProduct = viewModel.products[viewModel.currentCarouselIndex]
                    
                    NavigationLink(destination: ProductDetailView(product: currentProduct)) {
                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(currentProduct.title)
                                    .font(.headline)
                                    .lineLimit(2)
                                
                                Text(String(format: "$%.2f", currentProduct.price))
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            KFImage(currentProduct.imageURL)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 120, height: 120)
                                .clipShape(RoundedRectangle(cornerRadius: 10))//Ширина и высота закругленных углов прямоугольника.
                        }
                        .padding()
                        .background(Color(UIColor.systemBackground))
                        .cornerRadius(10)
                        .shadow(radius: 4)
                    }
                }
                ScrollView {
                    GeometryReader { geometry in
                        Color.clear
                            .onChange(of: geometry.frame(in: .global).minY) { offsetY in
                                withAnimation {
                                    showCarousel = offsetY > 100
                                }
                            }
                        
                    }
                    .frame(height: 0)
                    if viewModel.isLoading {
                        ProgressView("Загрузка")
                            .padding()
                    } else {
                        VStack(spacing: 16) {
                            ForEach(viewModel.filteredProducts) { product in
                                NavigationLink(destination: ProductDetailView(product: product)) {
                                    ProductCardView(product: product)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
        }
    }
}
    

