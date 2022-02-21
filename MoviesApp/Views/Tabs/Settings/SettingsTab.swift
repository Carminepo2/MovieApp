//
//  SettingsTab.swift
//  MoviesApp
//
//  Created by Carmine Porricelli on 14/02/22.
//

import SwiftUI


struct SettingsTab: View {
    
    
    var body: some View {
        NavigationView{
            VStack{
                VStack() {
                    List {
                        Group {
                            
                            
                            Section(header: sectionHeader(label: "User")) {
                                NavigationLink {
                                    CurrentLocation()
                                } label: {
                                    Text("Current Location")
                                }
                                
                                NavigationLink {
                                    ProgressView()
                                } label: {
                                    Text("Streaming Platforms")
                                }
                                
                                
                            }
                            
                            Section(header: sectionHeader(label: "General")) {
                                NavigationLink {
                                    ProgressView()
                                } label: {
                                    Text("Display")
                                }
                                NavigationLink {
                                    ProgressView()
                                } label: {
                                    Text("Storage")
                                }
                                NavigationLink {
                                    ProgressView()
                                } label: {
                                    Text("About")
                                }
                                
                            }
                        }
                        .listRowBackground(Color.clear)
                    }
                    .withBackground()
                    .listRowBackground(Color.clear)
                    .listStyle(.plain)
                    
                }
            }
            .navigationTitle("Settings")
            Spacer()
        }
    }
    
    // MARK: - Function
    private func sectionHeader(label: String) -> some View {
        Text(label.uppercased())
            .font(.callout.weight(.medium))
            .foregroundColor(.accentColor)
            .hLeading()
    }
}

struct SettingsTab_Previews: PreviewProvider {
    static var previews: some View {
        SettingsTab()
    }
}
