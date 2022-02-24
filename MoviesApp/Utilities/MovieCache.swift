//
//  MovieCache.swift
//  MoviesApp
//
//  Created by riccardo ruocco on 24/02/22.
//

import Foundation

class MovieCache {
    static private var cache = NSCache<NSNumber, Movie>()
    
    static subscript(id: Int64) -> Movie? {
        get {
            let cachedMovie = cache.object(forKey: id as NSNumber)
            print(cachedMovie, "pollo")
            
            return cachedMovie
            
        }
        set {
            if let newValue = newValue {
                cache.setObject(newValue, forKey: id as NSNumber)
            }
        }
    }
    
    private init() { }
}

