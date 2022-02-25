//
//  MovieStore.swift
//  MoviesApp
//
//  Created by Carmine Porricelli on 12/02/22.
//

import Foundation

class MovieAppModel {
    var allMovies:Array<Movie>
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
        allMovies = []
        watchListAlone = []
        watchListCouple = []
        watchListFriends = []
        watchListFamily = []
//        var movieToSave = MovieToSave(context: CoreDataManager.shared.persistentContainer.viewContext)
//        movieToSave.id = Movie.example.id
//        movieToSave.watchListItBelong = "alone"
//        savedMovies = [movieToSave]
        savedMovies = CoreDataManager.shared.readMovie()
        with = Company.alone
        movieAlreadyRecommended = []
    
        
    }
    
    func getMovieById(id:Int64) async throws-> Movie? {
        var movieToReturn = try await NetworkManager.shared.getMovieById(id: id)
        while(movieToReturn.id == Movie.example.id){
            movieToReturn = try await NetworkManager.shared.getMovieById(id: id)
        }
        
        allMovies.append(movieToReturn)
        return movieToReturn
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
    
    func setWatchList() async{
        if(with == Company.alone){
            for eachElement in savedMovies{
                do{
                    var movieToAdd:Movie = try await self.getMovie(id: eachElement.id)
                    watchListAlone.append(movieToAdd)
                }
                catch{
                    
                }
                
            }
        }
        else if(with == Company.couple){
        }
        else if(with == Company.family){
        }
        else if(with == Company.friends){
        }
    }
    private func getMovie(id:Int64) async throws->Movie{
        var movieToReturn:Movie? = nil
        movieToReturn = allMovies.first(where: {$0.id == id})
        if (movieToReturn == nil){
            movieToReturn = try await self.getMovieById(id: id)
        }
        return movieToReturn!
    }
    
    
    func getWatchList()->Array<Movie>{
        return self.watchListAlone
    }
    
    
    func addToWatchList(_ movie:Movie){
        var movieToSave = MovieToSave(context: CoreDataManager.shared.persistentContainer.viewContext)
        movieToSave.id = movie.id
        if(with == Company.alone){
            movieToSave.watchListItBelong = "alone"
            watchListAlone.append(movie)
        }
        else if(with == Company.couple){
            movieToSave.watchListItBelong = "couple"
            watchListCouple.append(movie)
        }
        else if(with == Company.family){
            movieToSave.watchListItBelong = "family"
            watchListFamily.append(movie)
        }
        else if(with == Company.friends){
            movieToSave.watchListItBelong = "friends"
            watchListFriends.append(movie)
        }
        
        savedMovies.append(movieToSave)
        CoreDataManager.shared.createMovie(movieToSave)
}
    
    
    func addToMovieAlreadyReccomended(movieToSave:Movie){
        movieAlreadyRecommended.append(movieToSave)
    }
    func getMovieAlreadyRecommended()->Array<Movie>{
        return self.movieAlreadyRecommended
    }
  
}

struct WatchList{
    
}
