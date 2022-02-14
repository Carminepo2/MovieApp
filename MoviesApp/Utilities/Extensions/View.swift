//
//  View.swift
//  AirQuotes
//
//  Created by Carmine Porricelli on 31/01/22.
//

import SwiftUI

extension View {
    
    /**
     - Returns: View horizontally aligned to the leading edge.
     */
    func hLeading() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    /**
     - Returns: View horizontally centered.
     */
    func hCenter() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .center)
    }
    
    /**
     - Returns: View horizontally aligned to the trailing edge.
     */
    func hTrailing() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    /**
     - Returns: View vertically centered.
     */
    func vCenter() -> some View {
        self
            .frame(maxHeight: .infinity, alignment: .center)
    }
    
    /**
     - Returns: View vertically aligned to the leading edge.
     */
    func vLeading() -> some View {
        self
            .frame(maxHeight: .infinity, alignment: .leading)
    }
    
    
    
    func getScreenBounds() -> CGRect {
        return UIScreen.main.bounds
    }
    
    
    /**
     - Returns: View with main background.
     */
    func withBackground(color: Color? = nil) -> some View {
        ZStack {
            if let color = color {
                color
            } else {
                Constants.AppBackground
                    .edgesIgnoringSafeArea(.all)
            }
            
            self
        }
    }
    
    func pressAction(onPress: @escaping (() -> Void), onRelease: @escaping (() -> Void)) -> some View {
        self
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({ _ in
                        onPress()
                    })
                    .onEnded({ _ in
                        onRelease()
                    })
            )
    }
    
    func innerShadow<S: Shape>(using shape: S, angle: Angle = .degrees(0), color: Color = .black, width: CGFloat = 6, blur: CGFloat = 4 ) -> some View {
        let finalX = CGFloat(cos(angle.radians - .pi/2))
        let finalY = CGFloat(sin(angle.radians - .pi/2))
        
        return self
            .overlay {
                shape
                    .stroke(color, lineWidth: width)
                    .offset(x: finalX * width * 0.6, y: finalY * width * 0.6)
                    .blur(radius: blur)
                    .mask(shape)
            }

    }
    
}
