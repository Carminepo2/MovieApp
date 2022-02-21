//
//  MovieProviders.swift
//  MoviesApp
//
//  Created by Carmine Porricelli on 21/02/22.
//

import SwiftUI

struct MovieProviders: View {
    let providers: CountryProviders?
    
    init(_ providers: CountryProviders?) {
        self.providers = providers
    }
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Available on: ")
                .font(.callout)
                .foregroundStyle(.secondary)
            
            HStack(spacing: 16) {
                ProviderIcon(isActive: isMovieAvailableFor(.Netflix), imageName: "netflix")
                ProviderIcon(isActive: isMovieAvailableFor(.DisneyPlus), imageName: "disney+")
                ProviderIcon(isActive: isMovieAvailableFor(.PrimeVideo), imageName: "prime-video")
                ProviderIcon(isActive: isMovieAvailableFor(.AppleTv), imageName: "apple-tv")
            }
            
        }
    }
    
    
    private func isMovieAvailableFor(_ provider: StreamingProvider) -> Bool {
        if let providers = providers {
            if let availableStreamingProviders = providers.flatrate {
                return availableStreamingProviders.contains { movieProvider in
                    movieProvider.providerId == provider.rawValue
                }
            }
        }
        
        return false
    }
}

fileprivate struct ProviderIcon: View {
    let isActive: Bool;
    let imageName: String;
    
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFill()
            .frame(width: 45, height: 45)
            .opacity(isActive ? 1 : 0.2)
    
    }
}

struct MovieProviders_Previews: PreviewProvider {
    static var previews: some View {
        MovieProviders(nil)
    }
}
