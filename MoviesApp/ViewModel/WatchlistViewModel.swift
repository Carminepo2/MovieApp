//
//  WatchlistViewModel.swift
//  MoviesApp
//
//  Created by Luigi Pedata on 16/02/22.
//

import Foundation

class WatchlistViewModel: ObservableObject {
    @Published var model: WatchListModel = WatchListModel()
    static var shared = WatchlistViewModel()
    private init(){
        Task{
            do{
                try await model.setWatchList()

            }
            catch{
                
            }

        }
    }
    
    func addToMovieAlreadyReccomended(_ movie:Movie){
        model.addToMovieAlreadyReccomended(movieToSave: movie)
    }
    func removeFromAlreadyReccomended(_ movie:Movie){
        model.removeFromAlreadyRecommended(movie)
    }
    
    
    func getWatchListId()->Array<Int64>{
        return model.getWatchListId()
    }
    
    func addToWatchList(_ movie:Movie){
        model.addToWatchList(movie)
    }
    func removeFromWatchList(_ movie:Movie){
        model.removeFromWatchList(movie)
    }
    
    func getMovieAlreadyRecommended()->Array<Movie>{
        return model.getMovieAlreadyRecommended()
    }
    func getWatchList()->Array<Movie>{
        return model.getWatchList()
    }


}
