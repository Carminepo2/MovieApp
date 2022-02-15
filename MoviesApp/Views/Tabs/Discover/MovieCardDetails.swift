//
//  MovieCardDetails.swift
//  MoviesApp
//
//  Created by Carmine Porricelli on 12/02/22.
//

import SwiftUI

struct MovieCardDetails: View {
    
    @Binding var showDetails: Bool
    @State private var scale: CGFloat = 1
    @State private var cornerRadius: CGFloat = 0
    
    
    let movie: Movie
    var animation: Namespace.ID
    
    var body: some View {
        
        ZStack {
            
            // MARK: - Movie Poster
            VStack {
                MoviePoster(posterPath: movie.posterPath)
                    .matchedGeometryEffect(id: "movie-poster", in: animation)
                
                Spacer()
            }
            
            // MARK: - Background Overlay
            LinearGradient(colors: [.clear, .init("Gray-700"), .init("Gray-700")], startPoint: .top, endPoint: .bottom)
            
            
            // MARK: - Movie Informations
            VStack {
                VStack(alignment: .trailing, spacing: 10) {
                    
                    // Visible part of the poster
                    Color.clear
                        .frame(maxHeight: 300)
                        .contentShape(Rectangle())
                    //MARK: Drag gesture to close modal
                        .gesture(
                            DragGesture(minimumDistance: 0, coordinateSpace: .global)
                                .onChanged(onPosterDragChanged)
                                .onEnded(onPosterDragEnded)
                        )
                    
                    Group {
                        //MARK: Title
                        Text(movie.title)
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .shadow(color: .black.opacity(0.5), radius: 4, x: 0, y: 2)
                            .matchedGeometryEffect(id: "movie-title", in: animation)
                        
                        //MARK: Duration and year
                        HStack(spacing: 20) {
                            Label(movie.formattedDuration, systemImage: "clock")
                            Label(movie.year, systemImage: "calendar")
                        }
                        .font(.body)
                        .matchedGeometryEffect(id: "movie-time", in: animation)
                        
                        //MARK: Ratings
                        StarsRating(voteAverage: movie.voteAverage)
                            .matchedGeometryEffect(id: "movie-stars", in: animation)
                        
                        //MARK: Overview
                        Text(movie.overview)
                            .padding(.top)
                        
                    }
                    .hLeading()
                }
                .padding()
                .foregroundColor(.white)
                
                Spacer()
            }
        }
        .cornerRadius(cornerRadius)
        .scaleEffect(scale)
        .edgesIgnoringSafeArea(.all)
    }
    
    // MARK: - Functions
    func onPosterDragChanged(value: DragGesture.Value) {
        let progress = value.translation.height / getScreenBounds().height
        
        let scale = 1 - progress
        if scale > 0.8 {
            self.scale = scale
        }
        
        let cornerRadius = (progress / 0.15) * 8
        if cornerRadius < Constants.CornerRadius {
            self.cornerRadius = cornerRadius
        }
    }
    
    func onPosterDragEnded(value: DragGesture.Value) {
        withAnimation(.spring()) {
            if scale < 0.9 {
                showDetails.toggle()
            }
            scale = 1
            
        }
    }
}

struct MovieDetails_Previews: PreviewProvider {
    struct TestView: View {
        @Namespace var ns
        var body: some View {
            MovieCardDetails(showDetails: .constant(true), movie: .example, animation: ns)
        }
    }
    static var previews: some View {
        TestView()
    }
}
