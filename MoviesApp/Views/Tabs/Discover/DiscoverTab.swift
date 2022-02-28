//
//  DiscoverTab.swift
//  MoviesApp
//
//  Created by Carmine Porricelli on 16/02/22.
//

import SwiftUI

struct DiscoverTab: View {
    @State private var isSwipeCardModalOpen: Bool = false
    @EnvironmentObject var discoverViewController: DiscoverViewModel
    @State private var isSearchMovieOpen: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                
                PopcornButton(isLoading: true, action: popCornButtonTapped)
                    .spotlight(enabled: true, title: "TAP")
                
                Text("Tap to start!")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                
            }
            .navigationTitle("Discover")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing)
                {Button{
                isSearchMovieOpen.toggle()
                } label: {
                    Image(systemName: "magnifyingglass")
                }}
                
            }
            .fullScreenCover(isPresented: $isSwipeCardModalOpen, content: {
                MovieSwipe(isSwipeCardModalOpen: $isSwipeCardModalOpen)
            })
            .fullScreenCover(isPresented: $isSearchMovieOpen, content: {
                SearchMovie(isSearchMovieOpen: $isSearchMovieOpen)
            })
            .withBackground()
            
        }
    }
    
    
    
    // MARK: - Functions
    func popCornButtonTapped() {
        
        if((!discoverViewController.isCardsSetted())&&(!discoverViewController.isCardsLoading()))
        {
            discoverViewController.setCardsLoading(true)
            Task{
                do{
                    try await discoverViewController.setCards()
                    discoverViewController.setCardsLoading(false)
                    isSwipeCardModalOpen = true
                }
                catch{
                    print("Errore caricamento dati")
                }
                
            }
        }
        else{
            if(!discoverViewController.isCardsLoading()){
                isSwipeCardModalOpen = true
                
            }
        }
        
        
        
        
        
        
    }
    
}

struct DiscoverTab_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverTab()
            .environmentObject(DiscoverViewModel())
    }
}
