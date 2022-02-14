//
//  DiscoverViewController.swift
//  MoviesApp
//
//  Created by Carmine Porricelli on 14/02/22.
//

import Foundation

class DiscoverViewController: ObservableObject {
    @Published var movieCards: Array<MovieCard> = []
    @Published var rotationDegreeCards: Array<Double> = []
    
    init() {
        for _ in 0..<Constants.NumOfCards {
            movieCards.append(MovieCard(movie: self.getRandomMovie()))
        }
    }
    
    func nextCard() {
        movieCards.removeLast()
        movieCards.insert(MovieCard(movie: self.getRandomMovie()), at: 0)
    }
    
    
    private func getRandomMovie() -> Movie {
        MovieStore.shared.movies.randomElement()!
    }
    
    struct MovieCard: Identifiable {
        fileprivate init(movie: Movie) {
            self.movie = movie
        }
        
        let id = UUID()
        var rotationDegree = Double(
            Int.random(in: -4...4)
        )
        let movie: Movie
        var xOffset: Double = 0
        var rotationOffset: Double = 0
    }
}
