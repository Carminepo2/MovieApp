//
//  MoviePoster.swift
//  MoviesApp
//
//  Created by Carmine Porricelli on 12/02/22.
//

import SwiftUI

struct MoviePoster: View {
    let posterPath: String?
    
    
    var body: some View {
        if let posterPath = posterPath {
            let url = URL(string: Constants.ImagesBasePath + posterPath)!
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .aspectRatio(Constants.CardAspectRatio, contentMode: .fit)
            
                
            } placeholder: {
                Color.clear
                    .aspectRatio(Constants.CardAspectRatio, contentMode: .fit)

            }
        } else {
            EmptyView() //TODO: Placeholder Image
        }
    }
}

struct MoviePoster_Previews: PreviewProvider {
    static var previews: some View {
        MoviePoster(posterPath: Movie.example.posterPath)
    }
}
