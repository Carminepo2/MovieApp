//
//  CleanCache.swift
//  MoviesApp
//
//  Created by Luca Basile on 01/03/22.
//

import SwiftUI

struct Storage: View {
    
    @State private var showingCleanWatchlist = false
    @State private var showingCleanHistory = false
    @State private var showingCleanCache = false
    
    var body: some View {
        VStack(spacing: 30) {
            
            Button("Clean Watchlist") {
                showingCleanWatchlist = true
            }
            .buttonStyle(RoundedRectangleButtonStyle())
            .confirmationDialog("Clear all watchlist data", isPresented: $showingCleanWatchlist, titleVisibility: .visible) {
                Button("Clear", role: .destructive) {
                    //TODO: Clear watchlist data
                    WatchlistViewModel.shared.cleanWatchList()
                }
            }
            
            Button("Clean History") {
                showingCleanHistory = true
            }
            .buttonStyle(RoundedRectangleButtonStyle(.secondary))
            .confirmationDialog("Clear all history data", isPresented: $showingCleanHistory, titleVisibility: .visible) {
                Button("Clear", role: .destructive) {
                    WatchlistViewModel.shared.cleanHistory()
                    //TODO: Clear history data
                }
            }
            
            Button("Clean Cache") {
                showingCleanCache = true
            }
            .confirmationDialog("Clear all cache data", isPresented: $showingCleanCache, titleVisibility: .visible) {
                Button("Clear", role: .destructive) {
                    //TODO: Clear Cache data
                }
            }
            
        }
        .padding()
        .withBackground()
        .navigationTitle("Storage")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct CleanCache_Previews: PreviewProvider {
    static var previews: some View {
        Storage()
    }
}
