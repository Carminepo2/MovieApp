//
//  MoviesApp.swift
//  MoviesApp
//
//  Created by Carmine Porricelli on 12/02/22.
//

import SwiftUI

@main
struct MoviesApp: App {
    
    init() {
        //UINavigationBar.changeAppearance(clear: true)
    }
    
    let movieStore = MovieStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(movieStore)
        }
    }
}
