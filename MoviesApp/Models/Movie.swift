//
//  Movie.swift
//  MoviesApp
//
//  Created by Carmine Porricelli on 12/02/22.
//

import Foundation


struct Movie: Codable, Identifiable {
    
    let id: Int64
    let posterPath: String?
    let backdropPath: String?
    let belongsToCollection: MovieCollection?
    let budget: Int
    let genres: Array<Genre>
    let homepage: String?
    let imdbId: String?
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Float
    let productionCompanies: Array<ProductionCompany>
    let productionCountries: Array<ProductionCountry>
    let releaseDate: String
    let revenue: Int
    let runtime: Int?
    let spokenLanguages: Array<SpokenLanguage>
    let status: String
    let tagline: String
    let title: String
    let video: Bool
    let voteAverage: Float
    let voteCount: Int
//     let keywords: Array<Keyword>
    let providers: Providers? = nil
    
    var formattedDuration: String {
        guard let movieRuntime = self.runtime else { return "-" }
        let hours = Int(movieRuntime / 60)
        let minutes = movieRuntime % 60
        return "\(hours)h\(minutes)m"
    }
    
    var year: String {
        self.releaseDate.components(separatedBy: "-")[0]
    }
    
    
    static let example = Movie(
        id: 634649,
        posterPath: "/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg",
        backdropPath: "/iQFcwSGbZXMkeyKrxbPnwnRo5fl.jpg",
        belongsToCollection: nil,
        budget: 200000000,
        genres: [Genre(id: 1, name: "Genre 1"), Genre(id: 2, name: "Genre 2")],
        homepage: "https://www.spidermannowayhome.movie",
        imdbId: "tt10872600",
        originalLanguage: "en",
        originalTitle: "Spider-Man: No Way Home",
        overview: "Peter Parker is unmasked and no longer able to separate his normal life from the high-stakes of being a super-hero. When he asks for help from Doctor Strange the stakes become even more dangerous, forcing him to discover what it truly means to be Spider-Man.",
        popularity: 11286.376,
        productionCompanies: [],
        productionCountries: [],
        releaseDate: "2021-12-15",
        revenue: 1775000000,
        runtime: 148,
        spokenLanguages: [],
        status: "Released",
        tagline: "The Multiverse unleashed.",
        title: "Spider-Man: No Way Home",
        video: false,
        voteAverage: 8.4,
        voteCount: 7443
//        keywords: [],
        
    )
}

struct MovieCollection: Codable {
    let id: Int
    let name: String
    let posterPath: String
    let backdropPath: String
    
}


// MARK: - Genre
struct Genre: Codable, Identifiable {
    let id: Int
    let name: String
}

// MARK: - ProductionCompany
struct ProductionCompany: Codable, Identifiable {
    let id: Int
    let logoPath: String?
    let name: String
    let originCountry: String
}

// MARK: - ProductionCountry
struct ProductionCountry: Codable {
    let iso31661: String
    let name: String
}

// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
    let englishName: String
    let iso6391: String
    let name: String
}

// MARK: - Keyword
struct Keyword: Codable, Identifiable {
    let id: Int
    let name: String
}

// MARK: - Providers
struct Providers: Codable {
    let de: CountryProviders?
    let it: CountryProviders?
    let us: CountryProviders?
    
    enum CodingKeys: String, CodingKey {
        case de = "DE"
        case it = "IT"
        case us = "US"
    }
}

// MARK: - CountryProviders
struct CountryProviders: Codable {
    let link: String
    let rent: Array<MoovieProvider>?
    let buy: Array<MoovieProvider>?
    let flatrate: Array<MoovieProvider>?
}

// MARK: - MoovieProvider
struct MoovieProvider: Codable {
    let displayPriority: Int
    let logoPath: String
    let providerId: Int
    let providerName: String
}

enum Company{
    case noOne
    case couple
    case friends
    case family
}

struct shortMovie:Codable{
    var id:Int?
    var name:String?
}
