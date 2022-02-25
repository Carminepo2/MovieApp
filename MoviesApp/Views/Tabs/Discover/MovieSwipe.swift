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
    
    @State private var showDetails = false
    @State private var tappedMovie: Movie? = nil
    @Binding var isSwipeCardModalOpen: Bool
        
    
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
                                    // MARK: - Card behind
                                    MovieCard(movie: movieCard.movie)
                                        .rotationEffect(
                                            .degrees(movieCard.rotationDegree)
                                        )
                                    
                                } else {
                                    
                                    // MARK: - First Card
                                    MovieCard(movie: movieCard.movie, animation: animation)
                                        .rotationEffect(.degrees(movieCard.rotationDegree))
                                        .rotationEffect(.degrees(movieCard.rotationOffset))
                                    
                                        .offset(x: movieCard.xOffset)
                                        .onTapGesture {
                                            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 0.8)) {
                                                showDetails.toggle()
                                                tappedMovie = movieCard.movie
                                            }
                                        }
                                        .gesture(
                                            DragGesture()
                                                .onChanged(handleDragCard)
                                                .onEnded(handleEndDragCard)
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
        
    // MARK: - Drag Functions
    
    func handleDragCard(value: DragGesture.Value) {
        let scrollProgress = value.translation.width / getScreenBounds().width
        let cornerRadius = (scrollProgress / 0.20) * 4
        discoverViewController.movieCards[movieCards.last!].rotationOffset = cornerRadius
        discoverViewController.movieCards[movieCards.last!].xOffset = value.translation.width
    }
    
    func handleEndDragCard(value: DragGesture.Value) {
        let xTranslation = value.translation.width
        if xTranslation > 0 {
            if xTranslation > 150 {
                discoverViewController.makeMovieFavorite()
                return
            }
        } else {
            if xTranslation < -150 {
                discoverViewController.discardMovie()
                return
            }
        }
        withAnimation {
            discoverViewController.movieCards[movieCards.last!].xOffset = 0
            discoverViewController.movieCards[movieCards.last!].rotationOffset = 0
        }
    }
    
    // MARK: - Close Modal Function
    func closeButtonTapped() {
        isSwipeCardModalOpen = false
    }
}

struct SearchTab_Previews: PreviewProvider {
    
    static var previews: some View {
        MovieSwipe(isSwipeCardModalOpen: .constant(true))
    }
}
