//
//  SwipeActionsLabels.swift
//  MoviesApp
//
//  Created by Luigi Pedata on 03/03/22.
//

import SwiftUI

struct LikedLabel: View {
    var body: some View {
        HStack {
            Group {
                Image(systemName: "heart.fill")
                    .font(.title3)

                Text("YEP")
                    .font(.title3)
                    .fontWeight(.heavy)
            }
            .foregroundColor(Color("AccentColor"))
        }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .overlay(
                RoundedRectangle(cornerRadius: 100)
                    .strokeBorder(Color("AccentColor"), lineWidth: 3.5)
            )
    }
}

struct DiscardedLabel: View {
    var body: some View {
        HStack {
            Group {
                Image(systemName: "xmark")
                    .font(.title3)

                Text("NOPE")
                    .font(.title3)
                    .fontWeight(.heavy)
            }
            .foregroundColor(.white)
        }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .overlay(
                RoundedRectangle(cornerRadius: 100)
                    .strokeBorder(.white, lineWidth: 3.5)
            )
    }
}

struct SwipeActionsLabels_Previews: PreviewProvider {
    static var previews: some View {
        LikedLabel()
        DiscardedLabel()
    }
}
