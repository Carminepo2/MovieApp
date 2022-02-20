//
//  MovieCardGridItem.swift
//  MoviesApp
//
//  Created by Luigi Pedata on 16/02/22.
//

import SwiftUI
import Foundation

struct GridItemLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .center, spacing: 3) {
            configuration.icon
            configuration.title
        }
    }
}

struct MovieCardGridItem: View {
    let movie : Movie
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: Poster
            MoviePoster(posterPath: movie.poster_path, contentMode: .fit)
                
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    // MARK: Title
                    Text(movie.title)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                    // MARK: Duration & Year
                    HStack(spacing: 10) {
                        Label(movie.formattedDuration, systemImage: "clock").labelStyle(GridItemLabelStyle())
                        Label(movie.year, systemImage: "calendar").labelStyle(GridItemLabelStyle())
                    }
                    .font(.system(size: 13))
                }
                Spacer()
                // MARK: Arrow
                Image(systemName: "chevron.right")
            }
            .frame(alignment: .leading)
            .padding(12)
            .background(Color("Gray-700"))
        }
        .background(Color("Gray-800"))
        .cornerRadius(6)
        
    }
}

struct MovieCardGridItem_Previews: PreviewProvider {
    static var previews: some View {
        //MovieCardGridItem(movie: Movie.example)
        
        MovieCardGridItem(movie: Movie.example)
            .frame(width: 183)


    }
}
