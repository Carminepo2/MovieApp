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
            
            VStack {
                VStack() {
                    // MARK: - Saved for later Link
                    NavigationLink(destination: WatchlistSavedForLater()) {
                        HStack {
                            Text("👀 Saved for later")
                                .font(.headline)
                                .fontWeight(.semibold)
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .padding(10)
                        .background(Color("Gray-650"))
                        .cornerRadius(8)
                    }
                    .foregroundColor(Color.white)
                    
                    // MARK: - Watchlist grid
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        LazyVGrid(columns: twoColumnGrid, spacing: 24) {
                            ForEach(viewModel.getWatchList()) { newRecord in
                                NavigationLink {
                                    MovieDetails(movie: newRecord)
                                } label: { MovieCardGridItem(movie: newRecord) }
                                .foregroundColor(Color.white)
                            }
                            /*NavigationLink {
                             MovieDetails(movie: Movie.example)
                             } label: { MovieCardGridItem(movie: Movie.example) }
                             .foregroundColor(Color.white)
                             NavigationLink {
                             MovieDetails(movie: Movie.example)
                             } label: { MovieCardGridItem(movie: Movie.example) }
                             .foregroundColor(Color.white)
                             NavigationLink {
                             MovieDetails(movie: Movie.example)
                             } label: { MovieCardGridItem(movie: Movie.example) }
                             .foregroundColor(Color.white)*/
                        }
                    }
                    .padding(.top, 14)
                }
                .padding()
                .navigationTitle("Watchlist")
                .withBackground()
            }
        }
    }
}

struct WatchlistTab_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistTab()
            .environmentObject(WatchlistViewModel())
        
    }
}
