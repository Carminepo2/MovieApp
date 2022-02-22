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

    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Button(action: popCornButtonTapped) {
                    Image("Popcorns")
                        .resizable()
                        .scaledToFill()

                }
                .buttonStyle(SkeumorphicButtonStyle(.secondary))
                .frame(width: 252, height: 252)
                
                Text("Pop the corns to get suggestion")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    

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
        Task{
            do{
                try await discoverViewController.setCards()
                isSwipeCardModalOpen = true
                
                var valore = try await NetworkManager.shared.getProviderById(id: 299536)
                
                print(                valore.it?.flatrate![0].providerName)

            }
            catch{
                print("Errore caricamento dati")
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
