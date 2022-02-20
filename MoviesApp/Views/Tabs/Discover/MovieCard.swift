//
//  MovieCard.swift
//  MoviesApp
//
//  Created by Carmine Porricelli on 12/02/22.
//

import SwiftUI

struct MovieCard: View {
    let movie: Movie
    @Namespace var animationPlaceholder
    var animation: Namespace.ID?
    @EnvironmentObject var discoverViewController: DiscoverViewModel

    
    // If animation is not passed, it passes an animation id placeholder
    private var animationNamespace: Namespace.ID {
        animation != nil ? animation! : animationPlaceholder
    }
    
    var body: some View {
        ZStack {
            // MARK: - Movie Poster
            MoviePoster(posterPath: movie.posterPath, contentMode: .fill)
                .matchedGeometryEffect(id: "movie-poster", in: animationNamespace)
            
            // MARK: - Gradient Overlay
            posterOverlay()
            
            // MARK: - Movie Header
            VStack(spacing: Constants.HeaderVSpacing) {
                Spacer()
                
                Group {
                    // MARK: Title
                    Text(movie.title)
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .shadow(
                            color: Constants.MovieTitleTextShadowColor,
                            radius: Constants.MovieTitleTextShadowRadius,
                            x: Constants.MovieTitleTextShadowPosition.x,
                            y: Constants.MovieTitleTextShadowPosition.y
                        )
                        .matchedGeometryEffect(id: "movie-title", in: animationNamespace)
                    
                    // MARK: Overview
                    Text(movie.overview)
                        .font(.caption)
                        .lineLimit(Constants.CardMovieOverviewLineLimit)
                    
                    // MARK: Duration & Year
                    HStack(spacing: Constants.DurationYearHSpacing) {
                        Label(movie.formattedDuration, systemImage: "clock")
                        Label(movie.year, systemImage: "calendar")
                    }
                    .font(.body)
                    .matchedGeometryEffect(id: "movie-time", in: animationNamespace)
                    
                    // MARK: Rating
                    StarsRating(voteAverage: movie.voteAverage)
                        .matchedGeometryEffect(id: "movie-stars", in: animationNamespace)
                    
                }
                .hLeading()
                
            }
            .padding()
            .foregroundColor(.white)
            
        }
     
        .aspectRatio(Constants.CardAspectRatio, contentMode: .fit)
        .cornerRadius(Constants.CornerRadius)
        .padding(.horizontal)
        .shadow(
            color: Constants.CardShadowColor,
            radius: Constants.CardShadowRadius,
            x: Constants.CardShadowPosition.x,
            y: Constants.CardShadowPosition.y
        )
    }
    
    // MARK: - Functions
    func posterOverlay() -> some View {
        LinearGradient(
            gradient: Constants.PosterOverlayGradient,
            startPoint: .bottom, endPoint: .top
        )
    }
//    private func downloadData() async {
//        do {
//            try await discoverViewController.fetchImage(url)
//        } catch {
//            print(error)
//        }
//    }
}

struct CardView_Previews: PreviewProvider {
    
    private struct TestView: View {
        @Namespace var animation
        
        var body: some View {
            MovieCard(movie: Movie.example, animation: animation)
                .padding()
                .withBackground()
        }
    }
    
    static var previews: some View {
        TestView()
    }
}
