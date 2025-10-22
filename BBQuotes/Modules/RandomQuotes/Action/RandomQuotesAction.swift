import ComposableArchitecture
import Foundation

extension RandomQuotesFeature {
    enum Action: Equatable {
        case onAppear
        case getData(String)
        case quoteLoaded(QuoteModel, HTTPURLResponse)
        case characterLoaded(CharacterModel, HTTPURLResponse)
        case deathLoaded(DeathModel?, HTTPURLResponse)
        case failed(String) 
    }
}
