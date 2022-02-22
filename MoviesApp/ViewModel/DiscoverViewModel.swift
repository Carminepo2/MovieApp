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
    var advisor:GrandAdvisor = GrandAdvisor.shared
    
    
    init() {
        
    }
    
    @MainActor
    func setCards() async{
            for _ in 0..<Constants.NumOfCards {
                let movie = await getAdvice()
                if let unwrappedMovie = movie{
                    movieCards.append(MovieCard(movie: unwrappedMovie))

                }
            }
        
        
    }
    
    @MainActor
    func nextCard() async{
        movieCards.removeLast()
        await movieCards.insert(MovieCard(movie: self.getAdvice()!), at: 0)
    }
    
    
 
    // MARK: Riccardo Function
    
    func getAdvice() async->Movie?{
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
        
        return await self.getMovieById(id: idAdvice)
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
    func getMovieById(id:Int64) async->Movie?{
        return await networkingManager.getMovieById(id: id)
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
