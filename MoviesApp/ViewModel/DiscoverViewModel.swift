//
//  DiscoverViewModel.swift
//  MoviesApp
//
//  Created by Carmine Porricelli on 14/02/22.
//

import Foundation
import SwiftUI


class DiscoverViewModel: ObservableObject {
    @Published var movieCards: Array<MovieCard> = []
    @Published var rotationDegreeCards: Array<Double> = []
    @Published var model:MovieAppModel = MovieAppModel.shared
    @Published var watchListModel:WatchListModel = WatchListModel.shared
    
    @Published var networkingManager = NetworkManager.shared
    var advisor: GrandAdvisor = GrandAdvisor.shared
    var cardSetted:Bool = false
    var carLoading:Bool = false
    
    
    init() {
        
    }
    
    @MainActor
    func setCards() async throws{
            for _ in 0..<Constants.NumOfCards {
                let movie = try await getAdvice()
                if let unwrappedMovie = movie {
                    movieCards.append(MovieCard(movie: unwrappedMovie))
                }
            }
        cardSetted = true

         
    }
    func isCardsSetted()->Bool{
        return self.cardSetted
    }
    func isCardsLoading()->Bool{
        return self.carLoading
    }
    func setCardsLoading(_ value:Bool){
        carLoading = value
    }
    @MainActor
    func nextCard(voto:Double) async throws{
        
        let advice = try await self.getAdvice()
        var lastCard = movieCards.removeLast()
        var movieRemoved = lastCard.movie
        self.giveFeedback(drawValueId: movieRemoved.id, result: voto)
        self.addToMovieAlreadyReccomended(movieToSave: movieRemoved, voteOfTheMovie: Float(voto))
        
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
            let watchListId = watchListModel.getWatchListId()
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
        
    func giveFeedback(drawValueId:Int64,result:Double){
        advisor.giveFeedback(drawValueId: drawValueId, result: result)
    }

    func getMovieById(id:Int64) async throws-> Movie? {
        return try await model.getMovieById(id: id)
    }
    
    func addToMovieAlreadyReccomended(movieToSave:Movie,voteOfTheMovie:Float){
        movieToSave.vote = voteOfTheMovie
        self.model.addToMovieAlreadyReccomended(movieToSave: movieToSave)
    }
    
    func makeMovieFavorite() {
        withAnimation {
            self.movieCards[movieCards.last!].xOffset = 500
            self.movieCards[movieCards.last!].rotationOffset = 15
            Haptics.shared.play(.heavy)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {

                Task {
                    do{
                        try await self.nextCard(voto: 1.0)
                        withAnimation {
                            self.movieCards[self.movieCards.last!].rotationDegree = 0
                        }
                    }
                    catch{
                        print("Errore dati")
                    }
                }
            }
        }
    }
    func discardMovie() {

        // Remove discarded movie's poster image from cache
        if let posterPath = movieCards.last?.movie.posterPath {
            ImageCache.removeImageFromCache(with: Constants.ImagesBasePath + posterPath)
        }
        Haptics.shared.play(.soft)
        withAnimation {
            self.movieCards[movieCards.last!].xOffset = -500
            self.movieCards[movieCards.last!].rotationOffset = -15
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                Task{
                    do {
                        try await self.nextCard(voto: -1.0)
                        withAnimation {
                            self.movieCards[self.movieCards.last!].rotationDegree = 0
                        }
                    }
                    catch{
                        print("Errore caricamento dati")
                    }
                }
            }
        }
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
