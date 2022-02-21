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
    
    @State private var userCanSwipe = true
    
    
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
                        
                        DiscardFavoriteButtons(makeFavorite: makeMovieFavorite, discard: discardMovie)
                        
                    }
                    
                } else {
                    if let tappedMovie = tappedMovie {
                        MovieDetails(
                            movie: tappedMovie, showDetails: $showDetails,
                            animation: animation
                        )
                    }
                }
            }
            .withBackground()
            .navigationBarHidden(showDetails)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("1/10")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Close", action: closeButtonTapped)
                }
            }

        }
      
    }
    
    // MARK: - Favorite and discard Functions
    func makeMovieFavorite() {
        if !userCanSwipe { return }

        userCanSwipe = false
        withAnimation {
            discoverViewController.movieCards[movieCards.last!].xOffset = 500
            discoverViewController.movieCards[movieCards.last!].rotationOffset = 15
            Haptics.shared.play(.heavy)

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                userCanSwipe = true
                discoverViewController.nextCard()
                withAnimation {
                    discoverViewController.movieCards[movieCards.last!].rotationDegree = 0
                }
            }
            discoverViewController.giveFeedback(drawValueId: movieCards.last!.movie.id, result: 1.0)


        }
    }
    
    func discardMovie() {
        if !userCanSwipe { return }
        
        userCanSwipe = false

        // Remove discarded movie's poster image from cache
        if let posterPath = movieCards.last?.movie.posterPath {
            ImageCache.removeImageFromCache(with: Constants.ImagesBasePath + posterPath)
        }
        
        Haptics.shared.play(.soft)

        withAnimation {
            discoverViewController.movieCards[movieCards.last!].xOffset = -500
            discoverViewController.movieCards[movieCards.last!].rotationOffset = -15
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                userCanSwipe = true
                discoverViewController.nextCard()
                withAnimation {
                    discoverViewController.movieCards[movieCards.last!].rotationDegree = 0
                }
            }
            discoverViewController.giveFeedback(drawValueId: movieCards.last!.movie.id, result: -1.0)
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
                makeMovieFavorite()
                return
            }
        } else {
            if xTranslation < -150 {
                discardMovie()
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
