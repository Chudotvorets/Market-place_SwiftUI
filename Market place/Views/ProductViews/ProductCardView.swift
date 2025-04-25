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
    //let product: Product
    @EnvironmentObject var viewModel: ProductViewModel
    
    var body: some View {
        VStack {
            KFImage(product.imageURL)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: 200)
                //.cornerRadius(8)
            
            Text(String(format: "$%.2f", product.price))
                .font(.custom("AvenirNext-bold", size: 20))
                .foregroundColor(.red)
            
            HStack {
                Text(product.title)
                    .font(.headline)
                    .lineLimit(2)
            }
            
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

