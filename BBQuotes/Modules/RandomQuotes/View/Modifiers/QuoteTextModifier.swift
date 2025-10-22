//
//  QuoteTextModifier.swift
//  BBQuotes
//
//  Created by Moataz on 20/10/2025.
//

import SwiftUI

struct QuoteTextModifier: ViewModifier {
  
    
    func body(content: Content) -> some View {
        content .minimumScaleFactor(0.5)
            .foregroundStyle(.white)
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .multilineTextAlignment(.center)
            .background(.black.opacity(0.7))
            .clipShape(.rect(cornerRadius: 26))
            .padding(.horizontal)
    }
}

extension View {
    func quoteTextModifier(
    ) -> some View {
        modifier(QuoteTextModifier(
        ))
    }
}
