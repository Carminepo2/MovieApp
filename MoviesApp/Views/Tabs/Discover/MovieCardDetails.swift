//
//  MovieCardDetails.swift
//  MoviesApp
//
//  Created by Carmine Porricelli on 12/02/22.
//

import SwiftUI

struct MovieCardDetails: View {
    
    let movie: Movie
    @Binding var showDetails: Bool
    var animation: Namespace.ID?
    @Namespace var animationPlaceholder


    @State private var scale: CGFloat = 1
    @State private var cornerRadius: CGFloat = 0
    
    init(movie: Movie, showDetails: Binding<Bool> = .constant(true), animation: Namespace.ID? = nil) {
        self.movie = movie
        self._showDetails = showDetails
        self.animation = animation
    }
    
    // If animation is not passed, it passes an animation id placeholder
    private var animationNamespace: Namespace.ID {
        animation != nil ? animation! : animationPlaceholder
    }
    
    
    var body: some View {
        
        ZStack {
            
            // MARK: - Movie Poster
            VStack {
                MoviePoster(posterPath: movie.posterPath)
                    .matchedGeometryEffect(id: "movie-poster", in: animationNamespace)
                
                Spacer()
            }
            
            // MARK: - Background Overlay
            LinearGradient(colors: [.clear, .init("Gray-700"), .init("Gray-700")], startPoint: .top, endPoint: .bottom)
            
            
            // MARK: - Movie Informations
            ScrollView {
                VStack {
                    VStack(alignment: .trailing, spacing: 10) {
                        
                        // Visible part of the poster
                        Color.clear
                            .frame(height: 300)
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
                                .matchedGeometryEffect(id: "movie-title", in: animationNamespace)
                            
                            //MARK: Duration and year
                            HStack(spacing: 20) {
                                Label(movie.formattedDuration, systemImage: "clock")
                                Label(movie.year, systemImage: "calendar")
                            }
                            .font(.body)
                            .matchedGeometryEffect(id: "movie-time", in: animationNamespace)
                            
                            //MARK: Ratings
                            StarsRating(voteAverage: movie.voteAverage)
                                .matchedGeometryEffect(id: "movie-stars", in: animationNamespace)
                            
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
            MovieCardDetails(movie: .example, showDetails: .constant(true), animation: ns)
        }
    }
    static var previews: some View {
        TestView()
    }
}
