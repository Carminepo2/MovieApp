//
//  ContentView.swift
//  MoviesApp
//
//  Created by Carmine Porricelli on 12/02/22.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        TabView {
            // MARK: - Search Tab
            DiscoverTab()
                .withBackground()
                .environmentObject(DiscoverViewModel())
                .tabItem {
                    Label("Discover", systemImage: "globe.americas")
                }
            
            // MARK: - Search Tab
            SearchTab()
                .withBackground()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            
            
            // MARK: - Watchlist Tab
            WatchlistTab()
                .withBackground()
                .environmentObject(WatchlistViewModel.shared)
                .tabItem {
                    Label("Watchlist", systemImage: "bookmark.fill")
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
