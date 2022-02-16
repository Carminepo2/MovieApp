//
//  DiscoverTab.swift
//  MoviesApp
//
//  Created by Carmine Porricelli on 16/02/22.
//

import SwiftUI

struct DiscoverTab: View {
    @State private var isSwipeCardModalOpen: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Button("Popcorn Button", action: popCornButtonTapped)
            }
            .navigationTitle("Discover")
            .fullScreenCover(isPresented: $isSwipeCardModalOpen, content: {
                MovieSwipe(isSwipeCardModalOpen: $isSwipeCardModalOpen)
                
            })
            .withBackground()
        }
    }
    
    
    // MARK: - Functions
    func popCornButtonTapped() {
        isSwipeCardModalOpen = true
    }
}

struct DiscoverTab_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverTab()
    }
}
