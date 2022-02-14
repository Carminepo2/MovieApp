//
//  DiscoverTab.swift
//  MoviesApp
//
//  Created by Carmine Porricelli on 14/02/22.
//

import SwiftUI

struct DiscoverTab: View {
    @EnvironmentObject var discoverViewController: DiscoverViewController
    
    @Namespace private var animation
    
    @State private var showDetails = false
    @State private var tappedMovie: Movie? = nil
    
    @State private var firstCardOffset: CGFloat = 0
    @State private var firstCardRotation: CGFloat = 0
    
    
    
    private var movieCards: Array<DiscoverViewController.MovieCard> {
        return discoverViewController.movieCards
    }
    
    private var rotationDegreeCards: Array<Double> {
        return discoverViewController.rotationDegreeCards
    }
    
    
    var body: some View {
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
                    
                    HStack(spacing: 80) {
                        Button(action: discardMovie) {
                            Circle()
                                .fill(Color("Gray-800"))
                                .frame(width: 70, height: 70)
                                .overlay {
                                    Image(systemName: "xmark")
                                }
                        }
                       
                                                
                        Button(action: makeMovieFavorite) {
                            Circle()
                                .fill(Color.accentColor)
                                .frame(width: 70, height: 70)
                                .overlay {
                                    Image(systemName: "heart")
                                }
                        }
                        
                        
                        
                    }
                    .padding()
                    .padding(.horizontal)
                }
                
            } else {
                if let tappedMovie = tappedMovie {
                    MovieCardDetails(
                        showDetails: $showDetails,
                        movie: tappedMovie,
                        animation: animation
                    )
                }
            }
            
        }
    }
    
    // MARK: - Favorite and discard Functions
    func makeMovieFavorite() {
        withAnimation {
            discoverViewController.movieCards[movieCards.last!].xOffset = 500
            discoverViewController.movieCards[movieCards.last!].rotationOffset = 15
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                discoverViewController.nextCard()
            }
        }
    }
    
    func discardMovie() {
        withAnimation {
            discoverViewController.movieCards[movieCards.last!].xOffset = -500
            discoverViewController.movieCards[movieCards.last!].rotationOffset = -15
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                discoverViewController.nextCard()
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
}

struct SearchTab_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverTab()
    }
}
