//
//  swipableCard.swift
//  MoviesApp
//
//  Created by Carmine Porricelli on 25/02/22.
//

import SwiftUI


fileprivate struct SwipableCard: ViewModifier {
    
    @EnvironmentObject var discoverViewModel: DiscoverViewModel
    
    var card: DiscoverViewModel.MovieCard
        
    let onSwipeRightSuccess: (() -> Void)?
    let onSwipeLeftSuccess: (() -> Void)?

    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(card.rotationOffset))
            .offset(x: card.xOffset)
            .gesture(
                DragGesture()
                    .onChanged(handleDragCard)
                    .onEnded(handleEndDragCard)
            )
    }
    
    // MARK: - Drag Functions
    
    func handleDragCard(value: DragGesture.Value) {
        let swipeProgress = value.translation.width / UIScreen.main.bounds.width
        discoverViewModel.rotateCard(card, degrees: (swipeProgress / 0.20) * 4)
        discoverViewModel.moveCard(card, offset: value.translation.width)
    }
    
    func handleEndDragCard(value: DragGesture.Value) {
        let swipeTranslation = value.translation.width
        if swipeTranslation > 0 {
            if swipeTranslation > 150 {
                withAnimation {
                    discoverViewModel.moveCard(card, offset: 500)
                    discoverViewModel.rotateCard(card, degrees: 15)
                }
                
                if let onSwipeRightSuccess = onSwipeRightSuccess {
                    onSwipeRightSuccess()
                }
                
                return
            }
        } else {
            if swipeTranslation < -150 {
                withAnimation {
                    discoverViewModel.moveCard(card, offset: -500)
                    discoverViewModel.rotateCard(card, degrees: -15)
                }

                if let onSwipeLeftSuccess = onSwipeLeftSuccess {
                    onSwipeLeftSuccess()
                }
                
                return
            }
        }
        
        withAnimation {
            discoverViewModel.moveCard(card, offset: 0)
            discoverViewModel.rotateCard(card, degrees: 0)
        }
    }
}


extension View {
    func swipableCard(
        card: DiscoverViewModel.MovieCard,
        onSwipeRightSuccess: (() -> Void)? = nil,
        onSwipeLeftSuccess: (() -> Void)? = nil
    ) -> some View {
        modifier(
            SwipableCard(
                card: card,
                onSwipeRightSuccess: onSwipeRightSuccess,
                onSwipeLeftSuccess: onSwipeLeftSuccess
            )
        )
    }
}
