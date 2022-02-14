//
//  RoundedRectangleButtonStyle.swift
//  AirQuotes
//
//  Created by Carmine Porricelli on 31/01/22.
//

import SwiftUI


struct RoundedRectangleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Spacer()
            configuration
                .label
                .foregroundColor(.black)
            Spacer()
        }
        .padding()
        .foregroundColor(.black)
        .background(Color.accentColor)
        .cornerRadius(Constants.CornerRadius)
        .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}


struct RoundedRectangleButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button("Apply", action: {})
            .buttonStyle(RoundedRectangleButtonStyle())
        
        Button("Apply", action: {})
            .buttonStyle(RoundedRectangleButtonStyle())
            .preferredColorScheme(.dark)

    }
}

