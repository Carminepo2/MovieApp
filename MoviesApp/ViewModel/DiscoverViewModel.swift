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
    var advisor:GrandAdvisor = GrandAdvisor.shared
    
    init(){
    }
    @MainActor
    func setCards() async{
        for _ in 0..<Constants.NumOfCards {
            await movieCards.append(MovieCard(movie: self.getAdvice()))
        }
    }
    
    @MainActor
    func nextCard() async{
        movieCards.removeLast()
        await movieCards.insert(MovieCard(movie: self.getAdvice()), at: 0)

    }
    
    
 
    // MARK: Riccardo Function

   
    
    
    func getAdvice() async->Movie{
        var isAdvisorSetted = advisor.isAdvisorSetted
        var movieToReturn:Movie
        if(isAdvisorSetted == false){
            var watchListId = model.getWatchListId()
            var initialValues:[Int64:Double] = [:]
            for id in watchListId{
                initialValues[id] = 1.0
            }
            advisor.setAdvisor(initialValues: initialValues)
        }
        var idAdvice = advisor.getAdvice()
        movieToReturn = try! await getMovieById(id: idAdvice)
        
        
        return await movieToReturn
    }
    
    func getAllMovies()->Array<Movie>{
        return model.movies
    }
    func giveFeedback(drawValueId:Int64,result:Double){
        advisor.giveFeedback(drawValueId: drawValueId, result: result)
    }
    func chooseMovie(id:Int64){
        
    }
    private func addToWatchLater(id:Int64){
        
    }
    func getMovieById(id:Int64) async throws->Movie{
        var movieToReturn:Movie = Movie.example
        var urlComponent = URLComponents(string: "https://api.themoviedb.org")!
        var decoder = JSONDecoder()
        
        urlComponent.path = "/3/movie/\(id)"
        urlComponent.queryItems = [
            "api_key": "fadf21998f46c545c3f3de23ca5712ec"
        ].map { URLQueryItem(name: $0.key, value: $0.value) }
        print("L")
        
            let (data,response) = try await URLSession.shared.data(from: urlComponent.url!)
            if let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode == 200,
               let movie = try? decoder.decode(Movie.self, from: data){
                movieToReturn = movie
                print("H")
            }
        
     
        return movieToReturn
        
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
