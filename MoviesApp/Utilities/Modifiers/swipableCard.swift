//
//  swipableCard.swift
//  MoviesApp
//
//  Created by Carmine Porricelli on 25/02/22.
//

import SwiftUI


fileprivate struct SwipableCard: ViewModifier {
    
    @State private var xOffset: CGFloat = .zero
    @State private var rotation: CGFloat = .zero
        
    let onSwipeRightSuccess: (() -> Void)?
    let onSwipeLeftSuccess: (() -> Void)?

    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(rotation))
            .offset(x: xOffset)
            .gesture(
                DragGesture()
                    .onChanged(handleDragCard)
                    .onEnded(handleEndDragCard)
            )
    }
    
    // MARK: - Drag Functions
    
    func handleDragCard(value: DragGesture.Value) {
        let swipeProgress = value.translation.width / UIScreen.main.bounds.width
        rotation = (swipeProgress / 0.20) * 4
        xOffset = value.translation.width
    }
    
    func handleEndDragCard(value: DragGesture.Value) {
        let swipeTranslation = value.translation.width
        if swipeTranslation > 0 {
            if swipeTranslation > 150 {
                withAnimation {
                    xOffset = 500
                    rotation = 15
                }
                
                if let onSwipeRightSuccess = onSwipeRightSuccess {
                    onSwipeRightSuccess()
                }
                
                return
            }
        } else {
            if swipeTranslation < -150 {
                withAnimation {
                    xOffset = -500
                    rotation = -15
                }

                if let onSwipeLeftSuccess = onSwipeLeftSuccess {
                    onSwipeLeftSuccess()
                }
                
                return
            }
        }
        
        withAnimation {
            xOffset = 0
            rotation = 0
        }
    }
}


extension View {
    func swipableCard(
        onSwipeRightSuccess: (() -> Void)? = nil,
        onSwipeLeftSuccess: (() -> Void)? = nil
    ) -> some View {
        modifier(
            SwipableCard(
                onSwipeRightSuccess: onSwipeRightSuccess,
                onSwipeLeftSuccess: onSwipeLeftSuccess
            )
        )
    }
}
