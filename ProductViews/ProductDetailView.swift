//
//  ProductDetailView.swift
//  Market place
//
//  Created by dev on 15.11.2024.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI
import Kingfisher


struct ProductDetailView: View {
    
    let product: Product
    @EnvironmentObject var viewModel: ProductViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                KFImage(product.imageURL)
                    .resizable() //изменяемый размер
                    .aspectRatio(contentMode: .fit) //соотношение сторон
                    .frame(height: 300) //рамка
                
                Text(product.title)
                    .font(.title)
                    .padding(.bottom, 8)
                
                Text(String(format: "$%.2f", product.price))
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Text(product.description)
                    .font(.body)
                    .padding(.top, 8)
                
                Spacer()
            }
            .padding()
        }
    }
}

