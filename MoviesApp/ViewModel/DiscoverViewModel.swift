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
        let example = Movie(
            id: 634649,
            posterPath: "/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg",
            // backdropPath: "/iQFcwSGbZXMkeyKrxbPnwnRo5fl.jpg",
            // belongsToCollection: nil,
            // budget: 200000000,
            genres: [],
            // homepage: "https://www.spidermannowayhome.movie",
            // imdbId: "tt10872600",
            originalLanguage: "en",
            originalTitle: "Spider-Man: No Way Home",
            overview: "Peter Parker is unmasked and no longer able to separate his normal life from the high-stakes of being a super-hero. When he asks for help from Doctor Strange the stakes become even more dangerous, forcing him to discover what it truly means to be Spider-Man.",
            // popularity: 11286.376,
            // productionCompanies: [],
            // productionCountries: [],
            releaseDate: "2021-12-15",
            // revenue: 1775000000,
            runtime: 148,
            // spokenLanguages: [],
            // status: "Released",
            tagline: "The Multiverse unleashed.",
            title: "Spider-Man: No Way Home",
            // video: false,
            voteAverage: 8.4,
            // voteCount: 7443,
            // keywords: [],
            providers: Providers.init(de: nil, it: nil, us: nil)
        )
        var movieToReturn:Movie? = nil
        
        Task{
            do{
                var movieToReturn = try await model.getMovieById(id: id)
            }
            catch{
                
            }
        }
        
        return movieToReturn ?? example
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
