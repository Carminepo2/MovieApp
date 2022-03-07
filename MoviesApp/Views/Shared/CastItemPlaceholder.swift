//
//  CastItemPlaceholder.swift
//  MoviesApp
//
//  Created by Luigi Pedata on 07/03/22.
//

import SwiftUI

struct CastItemPlaceholder: View {
    var body: some View {
        GeometryReader { geometry in
            Image(systemName: "person.crop.circle")
                .foregroundColor(.white)
                .font(.system(size: geometry.size.width * 0.175))
                .padding(10)
                .background(.gray)
                .cornerRadius(100)
        }
    }
}

struct CastItemPlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        CastItemPlaceholder()
    }
}
