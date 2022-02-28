//
//  AllLanguages.swift
//  MoviesApp
//
//  Created by Luca Basile on 22/02/22.
//

import SwiftUI

struct AllLanguages: View {
    
    let languages = ["English", "Italian", "German"]
    @State private var selectedLanguage = "English"
    
    
    var body: some View {
        List {
            ForEach(languages,id: \.self) { language in
                HStack{
                    Text(language)
                    Spacer()
                    if selectedLanguage == language {
                        Image(systemName: "checkmark")
                            .foregroundColor(.accentColor)
                    }
                }
                .listRowBackground(Color.clear)
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedLanguage = language
                }
                
            }
        }
        .padding(.vertical)
        .withBackground()
        .listStyle(.plain)
    }
}

struct AllLanguages_Previews: PreviewProvider {
    static var previews: some View {
        AllLanguages()
    }
}
