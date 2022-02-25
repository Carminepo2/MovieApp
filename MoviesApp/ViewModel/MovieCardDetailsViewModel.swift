//
//  MovieCardDetailsViewModel.swift
//  MoviesApp
//
//  Created by riccardo ruocco on 25/02/22.
//

import Foundation

class MovieCardDetailsViewModel: ObservableObject {
    @Published var model:MovieAppModel = MovieAppModel.shared
    
    init(){
       
    }
    
    
    func addToWatchList(id:Int64){
        model.addToWatchList(id: id)
    }

}
