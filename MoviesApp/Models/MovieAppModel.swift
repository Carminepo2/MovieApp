//
//  MovieStore.swift
//  MoviesApp
//
//  Created by Carmine Porricelli on 12/02/22.
//

import Foundation

class MovieAppModel {
    var savedMovies:Array<MovieToSave>
    var watchListAlone:Array<Movie>
    var watchListCouple:Array<Movie>
    var watchListFriends:Array<Movie>
    var watchListFamily:Array<Movie>
    var with:Company
    var movieAlreadyRecommended:Array<Movie>
    
    static var shared = MovieAppModel()
    var networkManager = NetworkManager.shared
    
    private init(){
        watchListAlone = []
        watchListCouple = []
        watchListFriends = []
        watchListFamily = []
        savedMovies = CoreDataManager.shared.readMovie()
        with = Company.alone
        movieAlreadyRecommended = []
    }
    func getWatchListId()->Array<Int64>{
        var idListToReturn:Array<Int64> = []
        if(with == Company.alone){
            
        }
        else if(with == Company.couple){
            
        }
        else if(with == Company.family){
            
        }
        else if(with == Company.friends){
            
        }
        return idListToReturn
    }
    
//    func setWatchLists() async{
//        for aMovie in savedMovies{
//            var movieToPick = try await NetworkManager.shared.getMovieById(id: aMovie.id)
//            if(aMovie.watchListItBelong == "alone"){
//                self.watchListAlone.append(movieToPick)
//            }
//            else if(aMovie.watchListItBelong == "couple"){
//                self.watchListCouple.append(movieToPick)
//            }
//            
//
//            
//        }
//    }
    func getWatchList()->Array<Movie>{
        var watchListToReturn:Array<Movie> = []
        if(with == Company.alone){
        }
        else if(with == Company.couple){
        }
        else if(with == Company.family){
        }
        else if(with == Company.friends){
        }
        return watchListToReturn
    }
    
    
    func addToWatchList(id:Int64){
        var movieToSave = MovieToSave(context: CoreDataManager.shared.persistentContainer.viewContext)
        movieToSave.id = id
        if(with == Company.alone){
            movieToSave.watchListItBelong = "alone"
        }
        else if(with == Company.couple){
            movieToSave.watchListItBelong = "couple"
        }
        else if(with == Company.family){
            movieToSave.watchListItBelong = "family"
        }
        else if(with == Company.friends){
            movieToSave.watchListItBelong = "friends"
        }
        CoreDataManager.shared.createMovie(movieToSave)
        
}
    
    
    func addToMovieAlreadyReccomended(movieToSave:Movie){
        movieAlreadyRecommended.append(movieToSave)
    }
    func getMovieAlreadyRecommended()->Array<Movie>{
        return self.movieAlreadyRecommended
    }
  

}
