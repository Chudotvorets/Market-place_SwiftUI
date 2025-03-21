//
//  ContentView.swift
//  Market place
//
//  Created by dev on 14.11.2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewProductModel = ProductViewModel(favoritesService: FavoritesService())
    
    var body: some View {
        TabView {
            ProductListView()
                .environmentObject(viewProductModel)
                .tabItem {
                    Label("",systemImage: "list.bullet")
                }
            FavoritesView()
                .environmentObject(viewProductModel)
                .tabItem {
                    Label("Favorites",systemImage: "list.star")
            }
            
        }
    }
}

#Preview {
    ContentView()
}
