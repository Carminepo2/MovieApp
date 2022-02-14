//
//  DiscardFavoriteButtons.swift
//  MoviesApp
//
//  Created by Carmine Porricelli on 14/02/22.
//

import SwiftUI

struct DiscardFavoriteButtons: View {
    let makeFavorite: () -> Void
    let discard: () -> Void
    
    
    var body: some View {
        HStack(spacing: 80) {
            Button(action: discard) {
                Circle()
                    .fill(Color("Gray-800"))
                    .frame(width: 75, height: 75)
                    .overlay {
                        Image(systemName: "xmark")
                            .font(.title.weight(.semibold))
                            .foregroundColor(.accentColor)
                    }
                    .innerShadow(using: Circle(), color: .black.opacity(0.25), blur: 5)

            }
           
                                    
            Button(action: makeFavorite) {
                Circle()
                    .fill(Color.accentColor)
                    .frame(width: 75, height: 75)
                    .overlay {
                        Image(systemName: "heart")
                            .font(.title.weight(.semibold))
                            .foregroundColor(.init("Gray-800"))

                    }
                    .innerShadow(using: Circle(), color: .white.opacity(0.55))
            
            }
        }
        .padding()
    }
    
}

struct DiscardFavoriteButtons_Previews: PreviewProvider {
    static var previews: some View {
        DiscardFavoriteButtons(makeFavorite: {}, discard: {})
    }
}
