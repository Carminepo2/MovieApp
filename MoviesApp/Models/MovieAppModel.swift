//
//  MovieStore.swift
//  MoviesApp
//
//  Created by Carmine Porricelli on 12/02/22.
//

import Foundation

class MovieAppModel {
    var allMovies:Array<Movie>
    var movieAlreadyRecommended:Array<Movie>
    
    static var shared = MovieAppModel()
    var networkManager = NetworkManager.shared
    
    private init(){
        allMovies = []
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
    
    
    
   
    
    private func getMovie(id:Int64) async throws->Movie{
        var movieToReturn:Movie? = nil
        movieToReturn = allMovies.first(where: {$0.id == id})
        if (movieToReturn == nil){
            movieToReturn = try await self.getMovieById(id: id)
        }
        return movieToReturn!
    }
    
    
    
    
    
   
    
    
    func addToMovieAlreadyReccomended(movieToSave:Movie){
        movieAlreadyRecommended.append(movieToSave)
    }
    func getMovieAlreadyRecommended()->Array<Movie>{
        return self.movieAlreadyRecommended
    }
  
}

struct WatchListModel{
    var alone:Array<Movie>
    var couple:Array<Movie>
    var friends:Array<Movie>
    var family:Array<Movie>
    var with:Company = Company.alone

    var savedMovies:Array<MovieToSave>
    static var shared = WatchListModel()
    
    private init(){
        alone = []
        couple = []
        friends = []
        family = []
        savedMovies = CoreDataManager.shared.readMovie()
    }

    
    
    
    
    mutating func addToWatchList(_ movie:Movie){
        var movieToSave = MovieToSave(context: CoreDataManager.shared.persistentContainer.viewContext)
        movieToSave.id = movie.id
        if(with == Company.alone){
            movieToSave.watchListItBelong = "alone"
            alone.append(movie)
            print("A")
        }
        else if(with == Company.couple){
            movieToSave.watchListItBelong = "couple"
            self.couple.append(movie)
        }
        else if(with == Company.family){
            movieToSave.watchListItBelong = "family"
            family.append(movie)
        }
        else if(with == Company.friends){
            movieToSave.watchListItBelong = "friends"
            friends.append(movie)
        }
        
        savedMovies.append(movieToSave)
        CoreDataManager.shared.createMovie(movieToSave)
    }
    func getWatchList()->Array<Movie>{
        
        return self.alone
    }
    
    func getWatchListId()->Array<Int64>{
        var idListToReturn:Array<Int64> = []
        return idListToReturn
    }
    
}
