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
    
    //MARK: Localization strings
    let discoverTabTitle = LocalizedStringKey("discover-tab-title")
    let callToActionText = LocalizedStringKey("discover-call-to-action")

    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                
                PopcornButton(isLoading: true, action: popCornButtonTapped)
                    //.spotlight(enabled: true, title: "TAP")
                
                Text(callToActionText)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
            }
            .navigationTitle(discoverTabTitle)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        DiscoverHistory()
                    } label: {
                        Image(systemName: "clock.arrow.circlepath")
                    }

                }
            }

            .fullScreenCover(isPresented: $isSwipeCardModalOpen, content: {
                MovieSwipe(isSwipeCardModalOpen: $isSwipeCardModalOpen)
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
