//
//  MovieStore.swift
//  MoviesApp
//
//  Created by Carmine Porricelli on 12/02/22.
//

import Foundation

class MovieAppModel {
    var movies:Array<Movie> = load("movies.json")
    var watchListAlone:Array<Movie>
    var watchListCouple:Array<Movie>
    var watchListFriends:Array<Movie>
    var watchListFamily:Array<Movie>
    var with:Company
    var movieAlreadyRecommended:Array<Movie>
    var chosenMovie:Movie?
    
    static var shared = MovieAppModel()

    
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
 
    
    
    func addToWatchList(id:Int64){
        
    }
    func addToMovieAlreadyReccomended(id:Int64){
        
    }
    func getMovieById(id:Int64)->Movie{
        var movieToReturn:Movie? = nil
   
//        var urlComponent = URLComponents(string: "https://api.themoviedb.org")!
//        var decoder = JSONDecoder()
//        urlComponent.path = "/3/movie/\(id)"
//        urlComponent.queryItems = ["api_key": "fadf21998f46c545c3f3de23ca5712ec"].map { URLQueryItem(name: $0.key, value: $0.value) }
//
//        let (data,response) = try await URLSession.shared.data(from: urlComponent.url!)
//        if let httpResponse = response as? HTTPURLResponse,httpResponse.statusCode == 200,let movie = try? decoder.decode(Movie.self, from: data){
//            movieToReturn = movie
//        }
//        else{
//            movieToReturn = nil
//        }
        
        
        for indexOfMovies in 0..<movies.count{
            if(movies[indexOfMovies].id == id){
                movieToReturn = movies[indexOfMovies]
            }
        }
        return movieToReturn!
    }
    
    
    
    
    
    private static func load<T: Decodable>(_ filename: String) -> T {
        let data: Data

        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }

}
