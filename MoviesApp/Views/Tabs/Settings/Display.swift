//
//  AppLanguage.swift
//  MoviesApp
//
//  Created by Luca Basile on 22/02/22.
//

import SwiftUI


struct Display: View {
   
    let languages = ["English", "Italian", "German"]

    
    var body: some View {
            List {
                NavigationLink {
                    AllLanguages()
                } label: {
                    HStack(){
                        Text("Language")
                        Spacer()
                        Text(languages[0])
                            .foregroundColor(.secondary)
                    }
                    
                    
                    
                } .listRowBackground(Color.clear)
                
                Toggle(isOn: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Is On@*/.constant(true)/*@END_MENU_TOKEN@*/) {
                                        Text("Show titles in original language")
                                    }
                .listRowBackground(Color.clear)
                
            }.padding(.vertical)
            .listStyle(.plain)
                .withBackground()
                
                
                .navigationTitle("Display")
                    .navigationBarTitleDisplayMode(.inline)
            
        }
    }

struct AppLanguage_Previews: PreviewProvider {
    static var previews: some View {
        Display()
    }
}
