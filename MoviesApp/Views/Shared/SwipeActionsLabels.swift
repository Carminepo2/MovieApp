//
//  SwipeActionsLabels.swift
//  MoviesApp
//
//  Created by Luigi Pedata on 03/03/22.
//

import SwiftUI

struct LikedLabel: View {
    var body: some View {
        Text("YEP")
            .font(.title3)
            .fontWeight(.heavy)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .foregroundColor(Color("AccentColor"))
            .overlay(
                RoundedRectangle(cornerRadius: 100)
                    .strokeBorder(Color("AccentColor"), lineWidth: 3.5)
            )
    }
}

struct DiscardedLabel: View {
    var body: some View {
        Text("NOPE")
            .font(.title3)
            .fontWeight(.heavy)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .foregroundColor(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 100)
                    .strokeBorder(Color.white, lineWidth: 3.5)
            )
    }
}

struct SwipeActionsLabels_Previews: PreviewProvider {
    static var previews: some View {
        LikedLabel()
        DiscardedLabel()
    }
}
