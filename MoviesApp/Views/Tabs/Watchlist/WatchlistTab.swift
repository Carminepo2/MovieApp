//
//  WatchlistTab.swift
//  MoviesApp
//
//  Created by Carmine Porricelli on 14/02/22.
//

import SwiftUI
import Foundation

struct WatchlistTab: View {
    
    @EnvironmentObject var viewModel: WatchlistViewModel
    
    
    private var twoColumnGrid = [GridItem(.flexible(), spacing:14), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            // MARK: - Watchlist grid
            ScrollView(.vertical, showsIndicators: false) {
                
                LazyVGrid(columns: twoColumnGrid, spacing: 24) {
                    ForEach(viewModel.getWatchList()) { newRecord in
                        NavigationLink {
                            MovieDetails(movie: newRecord)
                        } label: { MovieCardGridItem(movie: newRecord) }
                        .foregroundColor(Color.white)
                    }
                }
            }
            .padding(.horizontal)
            .navigationTitle("Watchlist")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        WatchlistSavedForLater()
                    } label: {
                        Image(systemName: "clock.arrow.circlepath")
                    }

                }
            }
            .withBackground()
              
            
            
            
        }
        
    }
        
}

struct WatchlistTab_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistTab()
            .environmentObject(WatchlistViewModel())
        
    }
}
