//
//  WatchlistSavedForLater.swift
//  MoviesApp
//
//  Created by Luigi Pedata on 15/02/22.
//

import SwiftUI

struct WatchlistSavedForLater: View {
    
    @Environment(\.presentationMode) var goback: Binding<PresentationMode>
    
    @EnvironmentObject var viewModel: WatchlistViewModel
    
    private var threeColumnGrid = [GridItem(.flexible(), spacing:11), GridItem(.flexible(), spacing:11), GridItem(.flexible())]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            LazyVGrid(columns: threeColumnGrid, spacing: 14) {
                ForEach(viewModel.getMovieAlreadyRecommended()) { newRecord in
                    NavigationLink {
                        MovieDetails(movie: newRecord)
                    } label: { MovieCardLikedGridItem(movie: newRecord) }
                    .foregroundColor(Color.white)
                }
            }
            .padding()
        }
        .navigationTitle("History")
        .navigationBarTitleDisplayMode(.inline)
        .withBackground()
    }
}

struct WatchlistSavedForLater_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistSavedForLater()
            .environmentObject(WatchlistViewModel())
    }
}
