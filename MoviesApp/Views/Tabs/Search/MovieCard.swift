//
//  MovieCard.swift
//  MoviesApp
//
//  Created by Carmine Porricelli on 12/02/22.
//

import SwiftUI

struct MovieCard: View {
    let movie: Movie
    var animation: Namespace.ID
    
    
    var body: some View {
        ZStack {
            // MARK: - Movie Poster
            MoviePoster(posterPath: movie.posterPath)
                .matchedGeometryEffect(id: "movie-poster", in: animation)
            
            
            // MARK: - Gradient Overlay
            posterOverlay()
            
            
            // MARK: - Movie Header
            VStack(spacing: 10) {
                Spacer()
                
                Group {
                    
                    Text(movie.title)
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .shadow(color: .black.opacity(0.5), radius: 4, x: 0, y: 2)
                        .matchedGeometryEffect(id: "movie-title", in: animation)
                    
                    Text(movie.overview)
                        .font(.caption)
                        .lineLimit(2)
                    
                    HStack(spacing: 20) {
                        Label("2h30m", systemImage: "clock")
                        Label("2h30m", systemImage: "calendar")
                    }
                    .font(.body)
                    .matchedGeometryEffect(id: "movie-time", in: animation)
                    
                    StarsRating(voteAverage: movie.voteAverage)
                        .matchedGeometryEffect(id: "movie-stars", in: animation)
                    
                }
                .hLeading()
                
            }
            .padding()
            .foregroundColor(.white)
            
            
        }
        .aspectRatio(Constants.CardAspectRatio, contentMode: .fit)
        .cornerRadius(Constants.CornerRadius)
    }
    
    
    // MARK: - Functions
    func posterOverlay() -> some View {
        LinearGradient(
            gradient: Gradient(
                colors: [
                    .init("Gray-900").opacity(0.75),
                    .init("Gray-900").opacity(0.55),
                    .init("Gray-900").opacity(0),
                ]
            ),
            startPoint: .bottom, endPoint: .top
        )
    }
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
