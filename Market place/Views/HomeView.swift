//
//  ProductListView.swift
//  Market place
//
//  Created by dev on 14.11.2024.
//

import Foundation
import SwiftUI
import Kingfisher

struct HomeView: View {
    
    @EnvironmentObject var viewModel: ProductViewModel
    @GestureState private var dragOffset: CGFloat = 0
    @State private var isSearchBarPinned: Bool = false
    @State private var searchBarOffset: CGFloat = 0
    @State private var showCarousel = true
   
    
    var body: some View {
        NavigationView {
                    VStack {
                        SearchBar(text: $viewModel.searchQuery)
                        ScrollView {
//                        Контейнер для получения данных о размере и положении вложенных элементов. Здесь он используется для работы с размерами карусели.
                        if showCarousel {
                            GeometryReader { geometry in
                                HStack(spacing: 0) {
                                    ForEach(viewModel.products.indices, id: \.self) { index in
                                        
                                        NavigationLink(destination: ProductDetailView(product: viewModel.products[index])) {
                                            CarouselCardView(product: viewModel.products[index])
                                            
                                        }
                                        .frame(width: geometry.size.width)
                                        
                                    }
                                    // viewModel.currentIndex: Индекс текущего товара. Управляет тем, какой товар отображается в центре карусели.
                                    // geometry.size.width: Используется для вычисления сдвига на ширину экрана.
                                    
                                    .frame(width: geometry.size.width, alignment: .leading)
                                    .offset(x: -CGFloat(viewModel.currentIndex) * geometry.size.width + dragOffset)
                                    .animation(.easeInOut, value: viewModel.currentIndex)
                                    //                                                                .gesture(
                                    //                                                                    DragGesture()
                                    //                                                                        .onEnded { gesture in
                                    //                                                                            viewModel.handleDragGesture(gesture, screenWidth: geometry.size.width)
                                    //                                                                        }
                                    //                                                                )
                                }
                            }
                            .frame(height: 150)
                        }
                        
                        
//                            GeometryReader { geometry in
//                                Color.clear
//                                    .onChange(of: geometry.frame(in: .global).minY) { offsetY in
//                                        withAnimation {
//                                            showCarousel = offsetY > 10
//                                        }
//                                    }
//                            }
                            //.frame(height: 0)
                        
//                                                    .padding(.horizontal)
//                                                    .background(GeometryReader { proxy in
//                                                        Color.clear.onAppear {
//                                                            searchBarOffset = proxy.frame(in: .global).minY
//                                                        }
//                                                        .onChange(of: proxy.frame(in: .global).minY) { value in
//                                                            isSearchBarPinned = value <= 0
//                                                        }
//                                                    })
//                                                    .zIndex(isSearchBarPinned ? 1 : 0)
                        
                        if viewModel.isLoading {
                            ProgressView("Загрузка")
                                .padding()
                        } else {
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
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



    

