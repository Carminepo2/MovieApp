//
//  SearchMovie.swift
//  MoviesApp
//
//  Created by Luca Basile on 28/02/22.
//

import SwiftUI

struct SearchMovie: View {
    @State private var searchText = ""
    @Binding var isSearchMovieOpen: Bool
    
    init (isSearchMovieOpen: Binding<Bool>) {
        self._isSearchMovieOpen = isSearchMovieOpen
        UITableView.appearance().backgroundColor=UIColor.clear
    }
    
    var body: some View {
        
        NavigationView{
            VStack{
                List{
                    MovieResultListItem(movie: Movie.example)
                        .listRowBackground(Color.clear)
                    MovieResultListItem(movie: Movie.example)
                        .listRowBackground(Color.clear)
                    MovieResultListItem(movie: Movie.example)
                        .listRowBackground(Color.clear)
                    MovieResultListItem(movie: Movie.example)
                        .listRowBackground(Color.clear)
                    MovieResultListItem(movie: Movie.example)
                        .listRowBackground(Color.clear)
                    MovieResultListItem(movie: Movie.example)
                        .listRowBackground(Color.clear)
                }
                    .listStyle(.plain)
                    .navigationTitle("Search")
                    .navigationBarTitleDisplayMode(.inline)
                    .withBackground()
                    
                    .searchable(text: $searchText)
                    .toolbar{
                        ToolbarItem(placement: .navigationBarTrailing)
                        {Button{
                            isSearchMovieOpen.toggle()
                        } label: {
                            Text("Close")
                        }}
                        
                    }
            }
        }
        
        
    }
}

struct SearchMovie_Previews: PreviewProvider {
    static var previews: some View {
        SearchMovie(isSearchMovieOpen: .constant(true))
    }
}
