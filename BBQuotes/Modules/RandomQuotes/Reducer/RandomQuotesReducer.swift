import ComposableArchitecture
import Foundation

@Reducer
struct RandomQuotesFeature {
    @Dependency(\.randomQuotesRepo) var repo

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.isLoading = true
                return .send(.getData(ProductionEnum.breakingBad.rawValue))
                
            case let .getData(production):
                state.isLoading = true
                return .run { send in
                    do {
                        let (quote, quoteRes): (QuoteModel, HTTPURLResponse) =
                            try await repo.getRandomQuote(from: production)
                        
                        await send(.quoteLoaded(quote, quoteRes))
                        
                        let (character, charRes): ([CharacterModel], HTTPURLResponse) =
                            try await repo.getCharacter(quote.character ?? "")
                        if let char = character.first {
                            let death = try await repo.getDeath()
                            let deathInfo = death.0.first {
                                $0.character?.lowercased().contains((char.name ?? "").lowercased()) == true
                            }
                            await send(.characterLoaded(char, charRes))
                            await send(.deathLoaded(deathInfo, death.1))
                        }
                    } catch {
                        await send(.failed(error.localizedDescription))
                    }
                }
                
            case let .quoteLoaded(quote, res):
                guard res.statusCode == 200 else {
                    return .send(.failed(res.debugDescription))
                }
                state.quote = quote
                return .none
                
            case let .characterLoaded(character, res):
                guard res.statusCode == 200 else {
                    return .send(.failed(res.debugDescription))
                }
                state.character = character
                return .none
                
            case let .deathLoaded(death, res):
                guard res.statusCode == 200 else {
                    return .send(.failed(res.debugDescription))
                }
                state.death = death
                state.isLoading = false
                return .none
                
            case let .failed(message):
                state.isLoading = false
                state.error = message
                return .none
            }
        }
    }
}
