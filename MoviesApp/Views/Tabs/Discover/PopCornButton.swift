//
//  PopCornButton.swift
//  MoviesApp
//
//  Created by Carmine Porricelli on 16/02/22.
//

import SwiftUI

struct PopCornButton: View {
    var body: some View {
        Circle()
            .frame(width: 252, height: 252)
            .overlay {
                Image("PopCorn")
            }

    }
}

struct PopCornButton_Previews: PreviewProvider {
    static var previews: some View {
        PopCornButton()
    }
}
