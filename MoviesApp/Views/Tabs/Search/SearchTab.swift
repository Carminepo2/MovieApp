//
//  SearchTab.swift
//  MoviesApp
//
//  Created by Carmine Porricelli on 14/02/22.
//

import SwiftUI

struct SearchTab: View {
    let movie = Movie.example
    @Namespace var animation
    
    @State var showDetails = false

    var body: some View {
        ZStack {
            if !showDetails {
                ZStack {
                    MovieCard(movie: movie, animation: animation)
                        .onTapGesture {
                            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 0.8)) {
                                showDetails.toggle()
                            }
                        }
                }
                .padding()

                
            } else {
                MovieCardDetails(
                    showDetails: $showDetails,
                    movie: movie,
                    animation: animation
                )
            }

        }
    }
}

struct SearchTab_Previews: PreviewProvider {
    static var previews: some View {
        SearchTab()
    }
}
