//
//  DiscoverViewModel.swift
//  MoviesApp
//
//  Created by Carmine Porricelli on 14/02/22.
//

import Foundation

class DiscoverViewModel: ObservableObject {
    @Published var movieCards: Array<MovieCard> = []
    @Published var rotationDegreeCards: Array<Double> = []
    @Published var model:MovieAppModel = MovieAppModel.shared
    @Published var movieToReturn:Movie?
    var advisor:GrandAdvisor = GrandAdvisor.shared
    
    init() {
        setCards()
    }
    
    func setCards(){
        for _ in 0..<Constants.NumOfCards {
            movieCards.append(MovieCard(movie: self.getAdvice()))
        }
    }
    
    
    func nextCard(){
        movieCards.removeLast()
        movieCards.insert(MovieCard(movie: self.getAdvice()), at: 0)
    }
    
    
 
    // MARK: Riccardo Function
    
    @MainActor
    func addFilm(filmToAdd:Movie?){
        movieToReturn = filmToAdd
    }
    
    func downloadFilm(id:Int64) async{
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
//                print(movie.title)
                await addFilm(filmToAdd: movie)
            }
            
        }
        catch DecodingError.keyNotFound(let key, let context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        }
        catch{
            print("altro")
        }
        
        
        
     
    }
   
    
    
    func getAdvice()->Movie{
        var isAdvisorSetted = advisor.isAdvisorSetted
        if(isAdvisorSetted == false){
            var watchListId = model.getWatchListId()
            var initialValues:[Int64:Double] = [:]
            for id in watchListId{
                initialValues[id] = 1.0
            }
            advisor.setAdvisor(initialValues: initialValues)
        }
        var idAdvice = advisor.getAdvice()
        return self.getMovieById(id: idAdvice)
    }
//    func getAllMovies()->Array<Movie>{
//        return model.movies
//    }
    func giveFeedback(drawValueId:Int64,result:Double){
        advisor.giveFeedback(drawValueId: drawValueId, result: result)
    }
    func chooseMovie(id:Int64){
        
    }
    private func addToWatchLater(id:Int64){
        
    }
    func getMovieById(id:Int64)->Movie{
        Task{
            await self.downloadFilm(id: id)
        }
        return self.movieToReturn ?? Movie.example
    }
 
    
    
    
    struct MovieCard: Identifiable {
        fileprivate init(movie: Movie) {
            self.movie = movie
        }
        
        let id = UUID()
        var rotationDegree = Double(
            Int.random(in: -4...4)
        )
        let movie: Movie
        var xOffset: Double = 0
        var rotationOffset: Double = 0
    }
}
