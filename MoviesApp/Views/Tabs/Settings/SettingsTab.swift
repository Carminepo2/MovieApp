//
//  SettingsTab.swift
//  MoviesApp
//
//  Created by Carmine Porricelli on 14/02/22.
//

import SwiftUI


struct SettingsTab: View {
    var locations = [
        "United States",
        "United Kingdom",
        "Italy",
        "Germany",
    ]
    
    // MARK: - Localized string
    let settigsTabTitle = LocalizedStringKey("settings-tab-title")
    let userSectionTitle = LocalizedStringKey("label-user-settings-section")
    let generalSectionTitle = LocalizedStringKey("label-general-settings-section")
    let currentLocationSettings = LocalizedStringKey("current-location-settings")
    let streamingPlatformSettings = LocalizedStringKey("streaming-platform-settings")
    let displaySettings = LocalizedStringKey("display-settings")
    let storageSettings = LocalizedStringKey("storage-settings")
    let aboutSettings = LocalizedStringKey("about-settings")

    
    var body: some View {
        NavigationView{
            VStack{
                VStack() {
                    List {
                        Group {
                            Section(header: sectionHeader(label: userSectionTitle)) {
                                NavigationLink { AllLocations() } label: {
                                    HStack {
                                        Text(currentLocationSettings)
                                        Spacer()
                                        Text(locations[0])
                                            .foregroundColor(.secondary)
                                    }
                                }
                                
                                NavigationLink { StreamingPlatforms() } label: {
                                    Text(streamingPlatformSettings)
                                }
                                
                                
                            }
                            
                            Section(header: sectionHeader(label: generalSectionTitle)) {
                                NavigationLink {
                                    Display()
                                } label: {
                                    Text(displaySettings)
                                }
                                NavigationLink {
                                    Storage()
                                } label: {
                                    Text(storageSettings)
                                }
                                NavigationLink {
                                    ProgressView()
                                } label: {
                                    Text(aboutSettings)
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
            .navigationTitle(settigsTabTitle)
            Spacer()
        }
    }
    
    // MARK: - Function
    private func sectionHeader(label: LocalizedStringKey) -> some View {
        Text(label)
            .font(.callout.weight(.medium))
            .foregroundColor(.accentColor)
            .textCase(.uppercase)
            .hLeading()
    }
}

struct SettingsTab_Previews: PreviewProvider {
    static var previews: some View {
        SettingsTab()
    }
}
