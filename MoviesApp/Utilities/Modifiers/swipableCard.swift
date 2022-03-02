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
    
    @Binding var verticalSwipeProgress: CGFloat
    @Binding var horizontalSwipeProgress: CGFloat
    
    let onSwipeRightSuccess: (() -> Void)?
    let onSwipeLeftSuccess: (() -> Void)?
    let onSwipeDownSuccess: (() -> Void)?
        
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(card.rotationOffset))
            .offset(card.offset)
            .gesture(
                DragGesture()
                    .onChanged(handleDragCard)
                    .onEnded(handleEndDragCard)
            )
    }
    
    // MARK: - Drag Functions
    
    func handleDragCard(value: DragGesture.Value) {
        horizontalSwipeProgress = value.translation.width / UIScreen.main.bounds.width
        verticalSwipeProgress = value.translation.height / UIScreen.main.bounds.height
        
        discoverViewModel.rotateCard(card, degrees: (horizontalSwipeProgress / 0.20) * 4)
        discoverViewModel.moveCard(card, offset: value.translation)
    }
    
    func handleEndDragCard(value: DragGesture.Value) {
        let swipeTranslation = value.translation
        
        // MARK: Card Swiped Right
        if swipeTranslation.width > 150 {
            withAnimation {
                discoverViewModel.moveCard(card, offset: .init(width: 500, height: 0))
                discoverViewModel.rotateCard(card, degrees: 15)
            }
            
            if let onSwipeRightSuccess = onSwipeRightSuccess {
                onSwipeRightSuccess()
            }
            
            return
        }
        
        // MARK: Card Swiped Left
        if swipeTranslation.width < -150 {
            withAnimation {
                discoverViewModel.moveCard(card, offset: .init(width: -500, height: 0))
                discoverViewModel.rotateCard(card, degrees: -15)
            }
            
            if let onSwipeLeftSuccess = onSwipeLeftSuccess {
                onSwipeLeftSuccess()
            }
            
            return
        }
        
        // MARK: Card Swiped Down
        if swipeTranslation.height > 300 {
            withAnimation {
                discoverViewModel.moveCard(card, offset: .init(width: 0, height: 800))
                discoverViewModel.rotateCard(card, degrees: 0)
            }
            
            if let onSwipeDownSuccess = onSwipeDownSuccess {
                onSwipeDownSuccess()
            }
            
            return
        }
        
        
        withAnimation {
            discoverViewModel.moveCard(card, offset: .zero)
            discoverViewModel.rotateCard(card, degrees: 0)
        }
    }
}


extension View {
    func swipableCard(
        card: DiscoverViewModel.MovieCard,
        verticalSwipeProgress: Binding<CGFloat>,
        horizontalSwipeProgress: Binding<CGFloat>,
        onSwipeRightSuccess: (() -> Void)? = nil,
        onSwipeLeftSuccess: (() -> Void)? = nil,
        onSwipeDownSuccess: (() -> Void)? = nil
    ) -> some View {
        modifier(
            SwipableCard(
                card: card,
                verticalSwipeProgress: verticalSwipeProgress,
                horizontalSwipeProgress: horizontalSwipeProgress,
                onSwipeRightSuccess: onSwipeRightSuccess,
                onSwipeLeftSuccess: onSwipeLeftSuccess,
                onSwipeDownSuccess: onSwipeDownSuccess
            )
        )
    }
}
