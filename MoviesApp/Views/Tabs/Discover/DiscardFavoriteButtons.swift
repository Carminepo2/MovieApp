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
        HStack(spacing: 160) {
            Button(action: discard) {
                Image(systemName: "xmark")
                    .font(.title.weight(.semibold))
                    .foregroundColor(.accentColor)
                
            }
            .buttonStyle(SkeumorphicButtonStyle(.secondary))
            .frame(width: 75, height: 75)
            
            
            
            Button(action: makeFavorite) {
                Image(systemName: "heart.fill")
                    .font(.title.weight(.semibold))
                    .foregroundColor(.init("Gray-800"))
            }
            .buttonStyle(SkeumorphicButtonStyle(.primary))
            .frame(width: 75, height: 75)
            
        }
        .padding()
    }
    
}

struct DiscardFavoriteButtons_Previews: PreviewProvider {
    static var previews: some View {
        DiscardFavoriteButtons(makeFavorite: {}, discard: {})
    }
}
