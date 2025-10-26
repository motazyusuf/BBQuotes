//
//  QuoteButtonModifier.swift
//  BBQuotes
//
//  Created by Moataz on 20/10/2025.
//


import SwiftUI

struct QuoteButtonModifier: ViewModifier {
    let production: ProductionType
    
    func body(content: Content) -> some View {
        content   .font(.title)
            .foregroundStyle(.white)
            .padding()
            .background(production.buttonColor)
            .clipShape(.rect(cornerRadius: 7))
            .shadow(color: production.shadowColor, radius: 2)
    }
}

extension View {
    func quoteButtonModifier(
        production: ProductionType

    ) -> some View {
        modifier(QuoteButtonModifier(
            production: production
        ))
    }
}
