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
    @Published var networkingManager = NetworkManager.shared
    var advisor: GrandAdvisor = GrandAdvisor.shared
    var cardSetted:Bool = false
    
    
    init() {
        
    }
    
    @MainActor
    func setCards() async throws{
            for _ in 0..<Constants.NumOfCards {
                let movie = try await getAdvice()
                if let unwrappedMovie = movie {
                    movieCards.append(MovieCard(movie: unwrappedMovie))
                    print("\(unwrappedMovie.id):\(unwrappedMovie.title)")
                }
            }
        cardSetted = true
         
    }
    func isCardsSetted()->Bool{
        return self.cardSetted
    }
    
    @MainActor
    func nextCard() async throws{
        
        let advice = try await self.getAdvice()
        movieCards.removeLast()
        
        if let notNullAdvice = advice {
            if (notNullAdvice.id != Movie.example.id){
                movieCards.insert(MovieCard(movie: notNullAdvice), at: 0)
            }
         
        }
        
    }
    
    
    func resetModel(){
        advisor.resetAdvisor()
    }
    
 
    // MARK: Riccardo Function
    
    func getAdvice() async throws -> Movie? {
        let isAdvisorSetted = advisor.isAdvisorSetted
        if(isAdvisorSetted == false){
            let watchListId = model.getWatchListId()
            var initialValues:[Int64:Double] = [:]
            for id in watchListId {
                initialValues[id] = 1.0
            }
            advisor.setAdvisor(initialValues: initialValues)
        }
        let idAdvice = advisor.getAdvice()
        
        var adviceToReturn = try await self.getMovieById(id: idAdvice)
        var elemento = try await getProvidersById(id: idAdvice)
        
        
        adviceToReturn?.providers = elemento
        return adviceToReturn
    }

    func getProvidersById(id:Int64) async throws -> Providers?{
        return try await networkingManager.getProvidersById(id: id).results
    }
    
//    func searchMovie()->Array<Movie>{
//        return model.movies
//    }
    
    
    func giveFeedback(drawValueId:Int64,result:Double){
        advisor.giveFeedback(drawValueId: drawValueId, result: result)
    }

//    private func addToWatchLater(id:Int64){
//
//    }
    func getMovieById(id:Int64) async throws-> Movie? {
        var movieToReturn = try await networkingManager.getMovieById(id: id)
        while(movieToReturn.id == Movie.example.id){
            movieToReturn = try await networkingManager.getMovieById(id: id)
        }
        
        return movieToReturn
    }
    func addToMovieAlreadyReccomended(movieToSave:Movie,voteOfTheMovie:Float){
        movieToSave.vote = voteOfTheMovie
        self.model.addToMovieAlreadyReccomended(movieToSave: movieToSave)
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
