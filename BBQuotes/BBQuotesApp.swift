//
//  BBQuotesApp.swift
//  BBQuotes
//
//  Created by Moataz on 18/10/2025.
//

import SwiftUI
import ComposableArchitecture

@main
struct BBQuotesApp: App {
    var body: some Scene {
        WindowGroup {
            RandomQuotesView(
                store: Store(
                    initialState: RandomQuotesFeature.State()
                ) {
                    RandomQuotesFeature()
                }
            )
        }
    }
}
