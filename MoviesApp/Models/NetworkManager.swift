//
//  NetworkManager.swift
//  MoviesApp
//
//  Created by riccardo ruocco on 21/02/22.
//

import Foundation

class NetworkManager{
    
    static var shared = NetworkManager()
    var downloadedFilm:Movie?{
        didSet{
            print("Je")
        }
    }
    
    private init(){
        
    }
    
   
    
    
    func getMovieById(id:Int64) async->Movie{
        var movieToReturn:Movie = Movie.example
        var urlComponent = URLComponents(string: "https://api.themoviedb.org")!
        let decoder = JSONDecoder()
        
        urlComponent.path = "/3/movie/\(id)"
        urlComponent.queryItems = [
            "api_key": "fadf21998f46c545c3f3de23ca5712ec"
        ].map { URLQueryItem(name: $0.key, value: $0.value) }
        
        do{
            let (data,response) = try await URLSession.shared.data(from: urlComponent.url!)
            
            
            if let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode == 200,
               let movie = try? decoder.decode(Movie.self, from: data){
                movieToReturn = movie
            }
            
        }
        catch DecodingError.keyNotFound(let key, let context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        }
        catch{
            print("altro")
        }
        return movieToReturn
        
    }
    
}

