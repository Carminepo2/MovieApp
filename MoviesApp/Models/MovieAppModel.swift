//
//  MovieStore.swift
//  MoviesApp
//
//  Created by Carmine Porricelli on 12/02/22.
//

import Foundation

class MovieAppModel {
    var movies:Array<Movie> = []
    var watchListAlone:Array<Movie>
    var watchListCouple:Array<Movie>
    var watchListFriends:Array<Movie>
    var watchListFamily:Array<Movie>
    var with:Company
    var movieAlreadyRecommended:Array<Movie>
    var chosenMovie:Movie?
    
    static var shared = MovieAppModel()
    var networkManager = NetworkManager.shared
    
    private init(){
        watchListAlone = []
        watchListCouple = []
        watchListFriends = []
        watchListFamily = []
        with = Company.noOne
        movieAlreadyRecommended = []
        chosenMovie = nil
    }
    func getWatchListId()->Array<Int64>{
        return []
    }
 
    
<<<<<<< Updated upstream
    
    func addToWatchList(id:Int64){
        
    }
    func addToMovieAlreadyReccomended(id:Int64){
        
=======
//    func setWatchLists() async{
//        for aMovie in savedMovies{
//            var movieToPick = try await NetworkManager.shared.getMovieById(id: aMovie.id)
//            if(aMovie.watchListItBelong == "alone"){
//                self.watchListAlone.append(movieToPick)
//            }
//            else if(aMovie.watchListItBelong == "couple"){
//                self.watchListCouple.append(movieToPick)
//            }
//        }
//        
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
>>>>>>> Stashed changes
    }
    func getMovieById(id:Int64){
    
    }
    
    
    
    
    
//    private static func load<T: Decodable>(_ filename: String) -> T {
//        let data: Data
//
//        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
//        else {
//            fatalError("Couldn't find \(filename) in main bundle.")
//        }
//
//        do {
//            data = try Data(contentsOf: file)
//        } catch {
//            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
//        }
//
//        do {
//            let decoder = JSONDecoder()
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
//            return try decoder.decode(T.self, from: data)
//        } catch {
//            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
//        }
//    }

}
