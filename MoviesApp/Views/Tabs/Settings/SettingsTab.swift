//
//  SettingsTab.swift
//  MoviesApp
//
//  Created by Carmine Porricelli on 14/02/22.
//

import SwiftUI


struct SettingsTab: View {
    var locations = [
        "location-united-states" : "United States",
        "location-united-kingdom" : "United Kingdom",
        "location-italy" : "Italy",
        "location-germany" : "Germany"
    ]
    
    var body: some View {
        NavigationView{
            VStack{
                VStack() {
                    List {
                        Group {
                            
                            
                            Section(header: sectionHeader(label: "User")) {
                                NavigationLink { AllLocations() } label: {
                                    HStack {
                                        Text("Current Location")
                                        Spacer()
                                        Text(locations["location-united-states"]!)
                                            .foregroundColor(.secondary)
                                    }
                                }
                                
                                NavigationLink { StreamingPlatforms() } label: {
                                    Text("Streaming Platforms")
                                }
                                
                                
                            }
                            
                            Section(header: sectionHeader(label: "General")) {
                                NavigationLink {
                                    Display()
                                } label: {
                                    Text("Display")
                                }
                                NavigationLink {
                                    Storage()
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
