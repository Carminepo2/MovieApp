//
//  ContentView.swift
//  MoviesApp
//
//  Created by Carmine Porricelli on 12/02/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var movieStore: MovieStore
    
    var body: some View {
        
        TabView {
            // MARK: - Search Tab
            SearchTab()
                .withBackground()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            
            // MARK: - Watchlist Tab
            WatchlistTab()
                .withBackground()
                .tabItem {
                    Label("Watchlist", systemImage: "play.tv")
                }
            
            // MARK: - Settings Tab
            SettingsTab()
                .withBackground()
                .tabItem {
                    Label("Search", systemImage: "gear")
                }
            
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
