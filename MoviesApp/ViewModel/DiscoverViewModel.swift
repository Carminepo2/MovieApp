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
    
    init() {
        for _ in 0..<Constants.NumOfCards {
            movieCards.append(MovieCard(movie: self.getRandomMovie()!))
        }
    }
    
    func nextCard(){
        movieCards.removeLast()
        movieCards.insert(MovieCard(movie: self.getRandomMovie()!), at: 0)

    }
    
    
    private func getRandomMovie() -> Movie? {
        return self.getAdvice()
    }
    // MARK: Riccardo Function

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
    func getMovieById(id:Int64)->Movie{        
        return model.getMovieById(id: id)
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
