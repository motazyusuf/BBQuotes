import ComposableArchitecture

extension RandomQuotesFeature {
    @ObservableState
    struct State: Equatable {
        var isLoading = false
        var quote: QuoteModel?
        var character: CharacterModel?
        var death: DeathModel?
        var error: String?
    }
}
