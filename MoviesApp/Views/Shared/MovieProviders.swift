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
    
    let movieProvidersTitle = LocalizedStringKey("movie-providers-title")
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(movieProvidersTitle)
                .font(.callout)
                .foregroundStyle(.secondary)
            
            HStack(spacing: 16) {
                ProviderIcon(isActive: isMovieAvailableFor(.Netflix), imageName: "netflix",url: "nflx://",itunesItem: "363590051")
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
    var url:String? = nil
    var itunesItem:String? = nil
    var body: some View {
        
        Button(action: {
            if(isActive && url != nil){
                
                if let urlOfTheProvider = URL(string: url!){
                    if(UIApplication.shared.canOpenURL(urlOfTheProvider)){
                        UIApplication.shared.open(urlOfTheProvider, options: [:], completionHandler: nil)
                    }
                    else{
                        if(itunesItem != nil){
//                            WatchlistViewModel.shared.openTheStore(itunesItem: itunesItem!)
                          
                        }
                    }
                }
            }
        }, label: {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 45, height: 45)
                .opacity(isActive ? 1 : 0.15)
                .clipShape(Circle())
        })
        
        
     
        
    }
}

struct MovieProviders_Previews: PreviewProvider {
    static var previews: some View {
        MovieProviders(nil)
    }
}
