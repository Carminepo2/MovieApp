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
    @State private var searchText = ""
    
    var movie: Set<Movie> {
        let movies = viewModel.getWatchList()
        if searchText.isEmpty {
            return movies
        }
        
        return movies.filter { $0.title.contains(searchText) }
    }
    
    
    private var twoColumnGrid = [GridItem(.flexible(), spacing:14), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: true) {
                // MARK: - Empty state placeholder
                if (viewModel.getWatchList().count == 0) {
                    VStack(spacing:10) {
                        Image("WatchlistEmptyStatePlaceholder")
                        Text("Bookmark movies to find them here")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                    .offset(y: UIScreen.main.bounds.height / 5.5)
                } else {
                    // MARK: - Swiped movies grid
                    LazyVGrid(columns: twoColumnGrid, spacing: 24) {
                        ForEach(Array(movie),id: \.self) { newRecord in
                            NavigationLink {
                                MovieDetails(movie: newRecord)
                            } label: { MovieCardGridItem(movie: newRecord) }
                            .foregroundColor(Color.white)
                        }
                    }
                    .padding()
                    //.padding(.horizontal)
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Watchlist")
            .withBackground()
        }
        .navigationViewStyle(.stack)
    }
    
}

struct WatchlistTab_Previews: PreviewProvider {
    static var previews: some View {
        var wVM = WatchlistViewModel.shared
        WatchlistTab()
            .environmentObject(wVM)
        
    }
}
