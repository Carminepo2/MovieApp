//
//  Movie.swift
//  provaAPI
//
//  Created by riccardo ruocco on 20/02/22.
//


import Foundation


struct Movie: Codable, Identifiable {
    var adult:Bool
    let id: Int64
    let poster_path: String?
     let backdrop_path: String?
     let belongs_to_collection: Collection?
     let budget: Int
    let genres: Array<Genre>
     let homepage: String?
     let imdbId: String?
    let original_language: String
    let original_title: String
    let overview: String
     let popularity: Float
     let production_companies: Array<ProductionCompany>
     let production_countries: Array<ProductionCountry>
    let release_date: String
     let revenue: Int
    let runtime: Int?
     let spoken_languages: Array<SpokenLanguage>
     let status: String
    let tagline: String
    let title: String
     let video: Bool
    let vote_average: Float
     let vote_count: Int
     let keywords: Array<Keyword>?
    let providers: Providers?
    
    var formattedDuration: String {
        guard let movieRuntime = self.runtime else { return "-" }
        let hours = Int(movieRuntime / 60)
        let minutes = movieRuntime % 60
        return "\(hours)h\(minutes)m"
    }
    
    var year: String {
        self.release_date.components(separatedBy: "-")[0]
    }
    
    
    static let example = Movie(
        adult:false,
        id: 634649,
        poster_path: "/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg",
        backdrop_path: "/iQFcwSGbZXMkeyKrxbPnwnRo5fl.jpg",
        belongs_to_collection: nil,
         budget: 200000000,
        genres: [],
         homepage: "https://www.spidermannowayhome.movie",
         imdbId: "tt10872600",
        original_language: "en",
        original_title: "Spider-Man: No Way Home",
        overview: "Peter Parker is unmasked and no longer able to separate his normal life from the high-stakes of being a super-hero. When he asks for help from Doctor Strange the stakes become even more dangerous, forcing him to discover what it truly means to be Spider-Man.",
         popularity: 11286.376,
        production_companies: [],
        production_countries: [],
        release_date: "2021-12-15",
        revenue: 1775000000,
        runtime: 148,
        spoken_languages: [],
        status: "Released",
        tagline: "The Multiverse unleashed.",
        title: "Spider-Man: No Way Home",
        video: false,
        vote_average: 8.4,
        vote_count: 7443,
         keywords: [],
        providers: Providers.init(de: nil, it: nil, us: nil)
    )
}


// MARK: - Collection
struct Collection: Codable, Identifiable {
    let id: Int
    let name: String
    let posterPath: String?
    let backdropPath: String?
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
    let origin_country: String
}

// MARK: - ProductionCountry
struct ProductionCountry: Codable {
    let iso_3166_1: String
    let name: String
}

// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
    let english_name: String
    let iso_639_1: String
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

