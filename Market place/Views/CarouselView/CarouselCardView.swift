//
//  CarouselCardView.swift
//  MarketPlace
//
//  Created by dev on 16/04/2025.
//

import Foundation
import SwiftUI

struct CarouselCardView: View {
    @EnvironmentObject var viewModel: ProductViewModel
    @Binding var products: [Product]
    @Binding var currentIndex: Int

    @GestureState private var dragOffset: CGFloat = 0
    @State private var isLongPressing: Bool = false

    var body: some View {
        GeometryReader { geometry in
            let itemWidth = geometry.size.width

            HStack(spacing: 0) {
                ForEach(products.indices, id: \.self) { index in
                    NavigationLink(
                        destination: ProductDetailView(product: products[index])
                    ) {
                        CarouselCardView(product: products[index])
                            .frame(width: itemWidth)
                    }
                }
            }
            .frame(width: itemWidth * CGFloat(products.count), alignment: .leading)
            .offset(x: -CGFloat(currentIndex) * itemWidth + dragOffset)
            .animation(.easeInOut(duration: 0.3), value: currentIndex)
            .contentShape(Rectangle()) // для распознавания касания на всей области
            .gesture(
                DragGesture()
                    .updating($dragOffset) { value, state, _ in
                        state = value.translation.width
                        viewModel.stopAutoScroll()
                    }
                    .onEnded { value in
                        let threshold = itemWidth / 2
                        let drag = value.translation.width
                        let delta = drag > threshold ? -1 : (drag < -threshold ? 1 : 0)
                        let newIndex = (currentIndex + delta).clamped(to: 0...(products.count - 1))
                        currentIndex = newIndex
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            viewModel.startAutoScroll()
                        }
                    }
            )
            .simultaneousGesture(
                LongPressGesture(minimumDuration: 0.3)
                    .onChanged { _ in
                        if !isLongPressing {
                            isLongPressing = true
                            viewModel.stopAutoScroll()
                        }
                    }
                    .onEnded { _ in
                        isLongPressing = false
                        viewModel.startAutoScroll()
                    }
            )
        }
        .frame(height: 150)
    }
}




extension Comparable {
    func clamped(to range: ClosedRange<Self>) -> Self {
        return min(max(self, range.lowerBound), range.upperBound)
    }
}
