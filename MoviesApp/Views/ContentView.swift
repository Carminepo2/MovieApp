//
//  ContentView.swift
//  MoviesApp
//
//  Created by Carmine Porricelli on 12/02/22.
//

import SwiftUI

struct ContentView: View {
    
    //MARK: Localization strings
    let discoverTabTitle = LocalizedStringKey("discover-tab-title")
    let watchlistTabTitle = LocalizedStringKey("watchlist-tab-title")
    let settingsTabTitle = LocalizedStringKey("settings-tab-title")
    
    var body: some View {
        
        TabView {
            // MARK: - Discover Tab
            DiscoverTab()
                .withBackground()
                .environmentObject(DiscoverViewModel())
                .tabItem {
                    Label(discoverTabTitle, systemImage: "globe.americas")
                }
            
            /* MARK: - Search Tab
            SearchTab()
                .withBackground()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            */
            
            // MARK: - Watchlist Tab
            WatchlistTab()
                .withBackground()
                .environmentObject(WatchlistViewModel.shared)
                .tabItem {
                    Label(watchlistTabTitle, systemImage: "bookmark.fill")
                }
            
            // MARK: - Settings Tab
            SettingsTab()
                .withBackground()
                .tabItem {
                    Label(settingsTabTitle, systemImage: "gear")
                }

        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
