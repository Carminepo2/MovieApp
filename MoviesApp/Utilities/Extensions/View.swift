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
    
    func innerShadow<S: Shape>(
        using shape: S,
        angle: Angle = .degrees(0),
        color: Color = .black,
        width: CGFloat = 6,
        offsetX: CGFloat = 0,
        offsetY: CGFloat = 0,
        blur: CGFloat = 4
    ) -> some View {
        
        let finalX = CGFloat(cos(angle.radians - .pi/2))
        let finalY = CGFloat(sin(angle.radians - .pi/2))
        
        return self
            .overlay(
                shape
                    .stroke(color, lineWidth: width)
                    .offset(x: finalX * width * offsetX, y: finalY * width * offsetY)
                    .blur(radius: blur)
                    .mask(shape)
            )
        
    }
    
}


// MARK: - https://www.hackingwithswift.com/quick-start/swiftui/how-to-detect-shake-gestures


// The notification we'll send when a shake gesture happens.
extension UIDevice {
    static let deviceDidShakeNotification = Notification.Name(rawValue: "deviceDidShakeNotification")
}

//  Override the default behavior of shake gestures to send our notification instead.
extension UIWindow {
     open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NotificationCenter.default.post(name: UIDevice.deviceDidShakeNotification, object: nil)
        }
     }
}

// A view modifier that detects shaking and calls a function of our choosing.
struct DeviceShakeViewModifier: ViewModifier {
    let action: () -> Void

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.deviceDidShakeNotification)) { _ in
                action()
            }
    }
}

// A View extension to make the modifier easier to use.
extension View {
    func onShake(perform action: @escaping () -> Void) -> some View {
        self.modifier(DeviceShakeViewModifier(action: action))
    }
}
