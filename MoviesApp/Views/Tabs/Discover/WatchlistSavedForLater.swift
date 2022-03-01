//
//  WatchlistSavedForLater.swift
//  MoviesApp
//
//  Created by Luigi Pedata on 15/02/22.
//

import SwiftUI

struct DiscoverHistory: View {
    @State private var searchQuery = ""
    @State private var filter: HistoryFilter = .all
    
    @EnvironmentObject var viewModel: DiscoverViewModel
    
    var filmHistory: Array<Movie> {
        var movies = WatchlistViewModel.shared.getMovieAlreadyRecommended()
        
        if filter == .discarded {
            movies = movies.filter { $0.vote != nil && $0.vote! < 0 }
        } else if filter == .loved {
            movies = movies.filter { $0.vote != nil && $0.vote! > 0 }
        }
        
        if searchQuery.isEmpty {
            return movies
        } else {
            return movies.filter { movie in
                movie.title.contains(searchQuery)
            }
        }
        
    }
    
    private var threeColumnGrid = [GridItem(.flexible(), spacing:11), GridItem(.flexible(), spacing:11), GridItem(.flexible())]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            // MARK: - Empty state placeholder
            if (filmHistory.count == 0) {
                VStack(spacing:10) {
                    Image("HistoryEmptyStatePlaceholder")
                    Text("The movies you swiped in the current session will be displayed here")
                        .font(.headline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .offset(y: UIScreen.main.bounds.height / 4)
            } else {
                // MARK: - Swiped movies grid
                LazyVGrid(columns: threeColumnGrid, spacing: 14) {
                    ForEach(filmHistory) { newRecord in
                        NavigationLink {
                            MovieDetails(movie: newRecord)
                        } label: { MovieCardLikedGridItem(movie: newRecord) }
                        .foregroundColor(Color.white)
                    }
                }
                .padding()
            }
        }
        .navigationTitle("History")
        .navigationBarTitleDisplayMode(.inline)
        .withBackground()
        .searchable(text: $searchQuery)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Picker(selection: $filter, label:Text("Filter options")) {
                        
                        Label("Loved", systemImage: "heart.fill")
                            .tag(HistoryFilter.loved)
                        
                        Label("Discarded", systemImage: "xmark")
                            .tag(HistoryFilter.discarded)
                        
                        Text("All")
                            .tag(HistoryFilter.all)
                        
                    }
                }
            label: {
                Image(systemName: "ellipsis.circle")
            }
                
            }
        }
        
    }
}

enum HistoryFilter {
    case loved, discarded, all
}

struct DiscoverHistory_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverHistory()
            .environmentObject(WatchlistViewModel.shared)
    }
}
