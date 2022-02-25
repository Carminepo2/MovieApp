//
//  MovieSwipe.swift
//  MoviesApp
//
//  Created by Carmine Porricelli on 14/02/22.
//

import SwiftUI

struct MovieSwipe: View {
    @EnvironmentObject var discoverViewController: DiscoverViewModel
    
    @Namespace private var animation
    
    @Binding var isSwipeCardModalOpen: Bool
    @State private var showDetails = false
    @State private var tappedMovie: Movie? = nil
        
    private var movieCards: Array<DiscoverViewModel.MovieCard> {
        return discoverViewController.movieCards
    }
    
    private var rotationDegreeCards: Array<Double> {
        return discoverViewController.rotationDegreeCards
    }
    
    
    var body: some View {
        NavigationView {
            ZStack {
                if !showDetails {
                    VStack {
                        ZStack {
                            ForEach(movieCards) { movieCard in
                                if movieCard.id != movieCards.last!.id {
                                    // MARK: - Cards behind
                                    MovieCard(movie: movieCard.movie)
                                        .rotationEffect(
                                            .degrees(movieCard.rotationDegree)
                                        )
                                    
                                } else {
                                    // MARK: - First Card
                                    MovieCard(movie: movieCard.movie, animation: animation)
                                        .rotationEffect(.degrees(movieCard.rotationDegree))
                                        .onTapGesture { showDetailsOf(movieCard.movie) }
                                        .swipableCard(
                                            onSwipeRightSuccess: discoverViewController.makeMovieFavorite, onSwipeLeftSuccess: discoverViewController.discardMovie
                                        )
                                }
                            }
                        }
                        .padding()
                        
                        DiscardFavoriteButtons(makeFavorite: discoverViewController.makeMovieFavorite, discard: discoverViewController.discardMovie)
                        
                    }
                    
                } else {
                    if let tappedMovie = tappedMovie {
                        MovieDetails(
                            movie: tappedMovie, showDetails: $showDetails,
                            animation: animation
                        )
                            .statusBar(hidden: showDetails)
                    }
                }
            }
            .withBackground()
            .navigationBarHidden(showDetails)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Close", action: closeButtonTapped)
                }
            }
            
        }
        
    }
    
    // MARK: - Functions
    
    func showDetailsOf(_ movie: Movie) {
        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 0.8)) {
            showDetails.toggle()
            tappedMovie = movie
        }
    }
    
    func closeButtonTapped() {
        isSwipeCardModalOpen = false
    }
}

struct SearchTab_Previews: PreviewProvider {
    
    static var previews: some View {
        MovieSwipe(isSwipeCardModalOpen: .constant(true))
    }
}
