//
//  CarouselCardView.swift
//  MarketPlace
//
//  Created by dev on 27.11.2024.
//

import Foundation
import SwiftUICore
import Kingfisher

struct CarouselCardView: View {
    let product: Product
    // let width: CGFloat
    
    var body: some View {
        //ZStack {
        HStack {
            KFImage(product.imageURL)
                .resizable()
                .scaledToFit()
                .frame(height: 150)
            
            Text(product.title)
                .font(.headline)
                .padding(.top, 10)
        }
        .padding(.horizontal, 10)
        
    }
}
