//
//  WatchlistViewModel.swift
//  MoviesApp
//
//  Created by Luigi Pedata on 16/02/22.
//

import Foundation

class WatchlistViewModel: ObservableObject {
    @Published var model:MovieAppModel = MovieAppModel.shared
    
    func getMovieAlreadyRecommended()->Array<Movie>{
        return model.getMovieAlreadyRecommended()
    }
    func getWatchList()->Array<Movie>{
        return model.getWatchList()
    }

}
