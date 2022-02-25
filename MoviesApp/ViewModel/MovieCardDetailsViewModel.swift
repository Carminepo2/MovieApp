//
//  MovieCardDetailsViewModel.swift
//  MoviesApp
//
//  Created by riccardo ruocco on 25/02/22.
//

import Foundation

class MovieCardDetailsViewModel: ObservableObject {
    
    
    @Published var model:MovieAppModel = MovieAppModel.shared
    @Published var watchListModel:WatchListModel = WatchListModel.shared
    
    init(){
       
    }
    
    func addToWatchList(_ movie:Movie){
        watchListModel.addToWatchList(movie)
    }

}
