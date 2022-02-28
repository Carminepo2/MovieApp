//
//  Storage.swift
//  MoviesApp
//
//  Created by Luca Basile on 28/02/22.
//

import SwiftUI

struct Storage: View {
    var body: some View {
        VStack() {
            List {
                Group {
                        NavigationLink {
                            ProgressView()
                        } label: {
                            Text("Clean Cache")
                        }
                        
                        NavigationLink {
                            ProgressView()
                        } label: {
                            Text("Clean Watchlist")
                        }
                    NavigationLink {
                        ProgressView()
                    } label: {
                        Text("Clean History")
                    }
                        
                        
                }
                .listRowBackground(Color.clear)
            }
            .withBackground()
            .listRowBackground(Color.clear)
            .listStyle(.plain)
            
        }
    }
}

struct Storage_Previews: PreviewProvider {
    static var previews: some View {
        Storage()
    }
}
