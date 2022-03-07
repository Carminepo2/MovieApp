//
//  MovieCredits.swift
//  MoviesApp
//
//  Created by Carmine Porricelli on 07/03/22.
//

import SwiftUI

struct MovieCredits: View {
    let credits: Credits
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(LocalizedStringKey("movie-credits-title"))
                .font(.callout)
                .foregroundStyle(.secondary)
            
            ScrollView(.horizontal) {
                HStack(spacing: 16) {
                    ForEach(credits.cast) { cast in
                        MovieCastPhoto(name: cast.name, path: cast.profilePath)
                    }
                }
            }
            
        }
    }
}

struct MovieCastPhoto: View {
    let name: String
    var url: URL? = nil
    
    @StateObject private var imageLoader = ImageLoaderViewModel()
    
    
    init(name: String, path: String?) {
        self.name = name
        if let path = path {
            self.url = URL(string: Constants.ImagesBasePath + path)
        }
    }
    
    
    var body: some View {
        VStack {
            
            if let url = url, let cachedImage = ImageCache[url.absoluteString] {
                Image(uiImage: cachedImage)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 120, height: 120)
                
            } else if let uiImage = imageLoader.uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 120, height: 120)
                
                
            } else {
                    Image(systemName: "person.crop.circle")
                        .foregroundColor(.white)
                        .font(.system(size: 40))
                        .background(.gray)
                        .cornerRadius(100)
                        .frame(width: 120, height: 120)

                
                .task {
                    await downloadImage()
                }
            }
            
            Text(name)
                .foregroundColor(.white)
        }
    }
    
    private func downloadImage() async {
        do {
            try await imageLoader.fetchImage(url)
        } catch {
            print(error)
        }
    }
}

struct MovieCast_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MovieCastPhoto(name: "John Formaggio", path: "/5XBzD5WuTyVQZeS4VI25z2moMeY.jpg")
            
            MovieCastPhoto(name: "John Formaggio", path: nil)

        }

    }
}
