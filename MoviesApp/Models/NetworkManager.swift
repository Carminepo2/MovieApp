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
    
    func getProviderById(id:Int64) async throws->Providers{
        var providerToReturn:Providers = Providers(de: nil, it: nil, us: nil)
        var urlComponent = URLComponents(string: "https://api.themoviedb.org")!
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        urlComponent.path = "/3/movie/\(id)/watch/providers"
        urlComponent.queryItems = [
            "api_key": "fadf21998f46c545c3f3de23ca5712ec"
        ].map { URLQueryItem(name: $0.key, value: $0.value) }
        
        do{
            let (data,response) = try await URLSession.shared.data(from: urlComponent.url!)
            if let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode == 200,
               let provider = try? decoder.decode(Providers.self, from: data){
                providerToReturn = provider
            }
        }
        catch{
            print("Hello")
        }
        return providerToReturn
        
    }
    
    
    func getMovieById(id:Int64) async throws -> Movie {
        
        if let cachedMovie = MovieCache[id] {
            return cachedMovie
        }
        
        var movieToReturn:Movie = Movie.example
        var urlComponent = URLComponents(string: "https://api.themoviedb.org")!
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        
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
        catch{
            throw DataException.ErrorGettingTheData
        }
        MovieCache[movieToReturn.id] = movieToReturn
        return movieToReturn
        
    }
    
    enum HttpError: Error {
        case badURL, badResponse, errorDecodingData, invalidURL
    }
    
}

