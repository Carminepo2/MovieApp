//
//  Constants.swift
//  MoviesApp
//
//  Created by Carmine Porricelli on 12/02/22.
//

import Foundation
import SwiftUI

struct Constants {
    static let ImagesBasePath = "https://image.tmdb.org/t/p/w500"
    static let CornerRadius = 8.0
    
    // MARK: - Card
    static let CardAspectRatio: CGFloat = 2/3 // Movie poster's aspect ratio
    static let NumOfCards = 5
    
    static let AppBackground = LinearGradient(
        gradient: Gradient(colors: [.init("Gray-700"), .init("Gray-800")]),
        startPoint: .top, endPoint: .bottom
    )
}
