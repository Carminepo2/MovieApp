//
//  DiscoverViewModel.swift
//  MoviesApp
//
//  Created by Carmine Porricelli on 14/02/22.
//

import Foundation
 
@MainActor

class DiscoverViewModel: ObservableObject {
    @Published var movieCards: Array<MovieCard> = []
    @Published var rotationDegreeCards: Array<Double> = []
    @Published var model:MovieAppModel = MovieAppModel.shared
    @Published var movieToReturn:Movie?
    
    var advisor:GrandAdvisor = GrandAdvisor.shared
    
    init() {
    }
    
    func getMovieById(_ id:Int64) async{
            do{
                self.movieToReturn = try await downloadMovieById(id)
                
            }
            catch{
                
            }
    }
    
    func downloadMovieById(_ id:Int64) async throws ->Movie?{
        
        var movieToReturn:Movie? = nil
        var urlComponent = URLComponents(string: "https://api.themoviedb.org")!
        var decoder = JSONDecoder()
        urlComponent.path = "/3/movie/\(id)"
        urlComponent.queryItems = [
        "api_key": "fadf21998f46c545c3f3de23ca5712ec"
        ].map { URLQueryItem(name: $0.key, value: $0.value) }
        
        let (data,response) = try await URLSession.shared.data(from: urlComponent.url!)
        if let httpResponse = response as? HTTPURLResponse,
        httpResponse.statusCode == 200,
        let movie = try? decoder.decode(Movie.self, from: data){
            movieToReturn = movie
        }
        
        return movieToReturn
    }
    
    
  

    // MARK: Riccardo Function
    func nextCard() async{
        movieCards.removeLast()
        await movieCards.insert(MovieCard(movie: self.getAdvice()), at: 0)

    }
    
    func setCards() async{
        for _ in 0..<Constants.NumOfCards {
            await movieCards.append(MovieCard(movie: self.getAdvice()))
        }
    }
   
    func getAdvice() async->Movie{
        
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
        await getMovieById(idAdvice)
        
        return movieToReturn ?? example
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
