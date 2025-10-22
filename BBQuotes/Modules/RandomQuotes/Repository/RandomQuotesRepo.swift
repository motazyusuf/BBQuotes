import ComposableArchitecture
import Foundation

struct RandomQuotesRepo {
    func getRandomQuote(from show: String) async throws -> (QuoteModel,HTTPURLResponse) {
        
        let response = try await NetworkHelper.request(
            url: Api.quotes,
            method: .get,
            queryParams: [URLQueryItem(name: "production", value: show)],
            responseType: QuoteModel.self,
        )
        
        return response
        
    }
    
    func getCharacter(_ name: String) async throws -> ([CharacterModel],HTTPURLResponse) {
        
        let response = try await NetworkHelper.request(
            url: Api.characters,
            method: .get,
            queryParams: [URLQueryItem(name: "name", value: name)],
            responseType: [CharacterModel].self,
        )
        
        return response
        
    }
    
    func getDeath() async throws -> ([DeathModel],HTTPURLResponse) {
        
        let response = try await NetworkHelper.request(
            url: Api.deaths,
            method: .get,
            responseType: [DeathModel].self,
        )
        
        return response
        
    }
}

extension DependencyValues {
    var randomQuotesRepo: RandomQuotesRepo {
        get { self[RandomQuotesRepoKey.self] }
        set { self[RandomQuotesRepoKey.self] = newValue }
    }
}

private enum RandomQuotesRepoKey: DependencyKey {
    static let liveValue = RandomQuotesRepo()
}
