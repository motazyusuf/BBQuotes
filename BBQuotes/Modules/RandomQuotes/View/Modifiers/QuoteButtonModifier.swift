//
//  QuoteButtonModifier.swift
//  BBQuotes
//
//  Created by Moataz on 20/10/2025.
//


import SwiftUI

struct QuoteButtonModifier: ViewModifier {
    let isBreakingBad: Bool
    
    func body(content: Content) -> some View {
        content   .font(.title)
            .foregroundStyle(.white)
            .padding()
            .background(isBreakingBad ? .breakingBadGreen : .betterCallSaulBlue)
            .clipShape(.rect(cornerRadius: 7))
            .shadow(color: isBreakingBad ? .breakingBadYellow : .betterCallSaulBrown, radius: 2)
    } 
}

extension View {
    func quoteButtonModifier(
        isBreakingBad: Bool

    ) -> some View {
        modifier(QuoteButtonModifier(
            isBreakingBad: isBreakingBad
        ))
    }
}
