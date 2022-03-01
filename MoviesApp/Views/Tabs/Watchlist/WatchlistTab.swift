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
    
    var movie:Set<Movie>{
        return viewModel.getWatchList()
    }
    
    
    private var twoColumnGrid = [GridItem(.flexible(), spacing:14), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ZStack{
                // MARK: - Empty state placeholder
                if (viewModel.getWatchList().count == 0) {
                    VStack(spacing:10) {
                        Image("WatchlistEmptyStatePlaceholder")
                        Text("Bookmark movies to find them here")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                } else {
                    // MARK: - Watchlist grid
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        LazyVGrid(columns: twoColumnGrid, spacing: 24) {
                            ForEach(Array(movie),id: \.self) { newRecord in
                                NavigationLink {
                                    MovieDetails(movie: newRecord)
                                } label: { MovieCardGridItem(movie: newRecord) }
                                .foregroundColor(Color.white)
                            }
                        }
                    }
                    
                    
                }
            }
            .padding(.horizontal)
            .navigationTitle("Watchlist")
            .withBackground()
        }
        
    }
    
}

struct WatchlistTab_Previews: PreviewProvider {
    static var previews: some View {
        var wVM = WatchlistViewModel.shared
        WatchlistTab()
            .environmentObject(wVM)
        
    }
}
