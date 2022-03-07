//
//  About.swift
//  MoviesApp
//
//  Created by Luigi Pedata on 07/03/22.
//

import SwiftUI

struct About: View {
    var body: some View {
        List {
            Section {
                Text("About")
            }
        }
            .withBackground()
    }
}

struct About_Previews: PreviewProvider {
    static var previews: some View {
        About()
    }
}
