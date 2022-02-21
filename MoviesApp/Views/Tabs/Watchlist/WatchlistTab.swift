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
    
    private var twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        //        Text("Watchlist")
        //        .font(.title2)
        //        .fontWeight(.semibold)
        //     1   .foregroundColor(.white)
        
        NavigationView {
            VStack {
                VStack() {
                    // MARK: - Saved for later Link
                    NavigationLink(destination: WatchlistSavedForLater()) {
                        Text("👀 Saved for later")
                            .font(.title2)
                            .fontWeight(.semibold)
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .padding(.vertical, 8)
                    .foregroundColor(Color.white)
                    Divider()
                        .frame(height: 1)
                    // MARK: - Watchlist grid
                    HStack {
                        Text("Recently watched")
                            .font(.title2)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding(.vertical, 8)
                }
                // MARK: - Watchlist grid
                ScrollView(.vertical, showsIndicators: false) {
                    
                    LazyVGrid(columns: twoColumnGrid) {
                        ForEach(viewModel.savedMovies) { newRecord in
                            NavigationLink {
                                MovieDetails(movie: Movie.example)
                            } label: { MovieCardGridItem(movie: Movie.example) }
                            .foregroundColor(Color.white)
                        }
                    }
                }
                .padding(.top, 4)
            }
            .padding()
            .navigationTitle("Watchlist")
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
