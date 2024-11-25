//
//  ProductCardView.swift
//  Market place
//
//  Created by dev on 23.11.2024.
//

import Foundation
import SwiftUI
import Kingfisher

struct ProductCardView: View {
    let product: Product
    @EnvironmentObject var viewModel: ProductViewModel
    
    var body: some View {
        HStack {
            KFImage(product.imageURL)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
                .cornerRadius(8)
            
            VStack(alignment: .leading) {
                Text(product.title)
                    .font(.headline)
                    .lineLimit(2)
                
                Text(String(format: "$%.2f", product.price))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button(action: {
                viewModel.toggleFavorite(for: product)
            }) {
                Image(systemName: viewModel.isFavorite(product) ? "heart.fill" : "heart")
                    .foregroundColor(viewModel.isFavorite(product) ? .red : .gray)
            }
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 4)
    }
}
