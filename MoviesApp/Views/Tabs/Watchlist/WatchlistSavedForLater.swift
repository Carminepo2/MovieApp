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
                ForEach(viewModel.savedMovies) { newRecord in
                    NavigationLink {
                        MovieDetails(movie: Movie.example)
                    } label: { MovieCardLikedGridItem(movie: Movie.example) }
                    .foregroundColor(Color.white)
                }
                /*NavigationLink {
                    MovieDetails(movie: Movie.example)
                } label: { MovieCardLikedGridItem(movie: Movie.example) }
                .foregroundColor(Color.white)
                NavigationLink {
                    MovieDetails(movie: Movie.example)
                } label: { MovieCardLikedGridItem(movie: Movie.example) }
                .foregroundColor(Color.white)
                NavigationLink {
                    MovieDetails(movie: Movie.example)
                } label: { MovieCardLikedGridItem(movie: Movie.example) }
                .foregroundColor(Color.white)
                NavigationLink {
                    MovieDetails(movie: Movie.example)
                } label: { MovieCardLikedGridItem(movie: Movie.example) }
                .foregroundColor(Color.white)*/
            }
        }
        
        .padding()
        .navigationTitle("👀 Saved for later")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action : {
            self.goback.wrappedValue.dismiss()
        }){
            Text(Image(systemName: "arrow.left"))
                .fontWeight(.semibold)
        })
        .withBackground()
    }
}

struct WatchlistSavedForLater_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistSavedForLater()
            .environmentObject(WatchlistViewModel())
    }
}
