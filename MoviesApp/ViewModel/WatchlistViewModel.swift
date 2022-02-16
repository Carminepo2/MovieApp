//
//  WatchlistViewModel.swift
//  MoviesApp
//
//  Created by Luigi Pedata on 16/02/22.
//

import Foundation

class WatchlistViewModel: ObservableObject {
    @Published var savedMovies: [Movie] = Array(repeating: Movie.example, count: 6)

}
