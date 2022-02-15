//
//  MoviePoster.swift
//  MoviesApp
//
//  Created by Carmine Porricelli on 12/02/22.
//

import SwiftUI

struct MoviePoster: View {
    var url: URL? = nil
    @StateObject private var imageLoader = ImageLoaderViewModel()
    
    init(posterPath: String?) {
        if let posterPath = posterPath {
            self.url = URL(string: Constants.ImagesBasePath + posterPath)
        }
    }
    
    var body: some View {
        VStack {
            if let uiImage = imageLoader.uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(Constants.CardAspectRatio, contentMode: .fit)

            } else {
                Color("Gray-700")
                    .aspectRatio(Constants.CardAspectRatio, contentMode: .fit)
            }
        }.task {
            await downloadImage()
        }
    }
    
    private func downloadImage() async {
        do {
            try await imageLoader.fetchImage(url)
        } catch {
            print(error)
            print(posterPath)
        }
    }

}

struct MoviePoster_Previews: PreviewProvider {
    static var previews: some View {
        MoviePoster(posterPath: Movie.example.posterPath)
    }
}
