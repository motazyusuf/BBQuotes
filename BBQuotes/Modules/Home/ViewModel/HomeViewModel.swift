//
//  HomeViewModel.swift
//  BBQuotes
//
//  Created by Moataz on 19/10/2025.
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    private let repo: BBRepo
    @Published var character: CharacterModel?
    @Published var quote: QuoteModel?
    @Published var death: DeathModel?
    @Published private var characterState: ApiFetchingState = .initial
    @Published private var quoteState: ApiFetchingState = .initial
    var state: ApiFetchingState {
        switch (characterState, quoteState) {
        case let (.failure(message), _),
            let (_, .failure(message)):
            return .failure(message)
        case (.loading, _,), (_, .loading):
            return .loading
        case (.success, .success):
            return .success
        default:
            return .initial
        }
    }
    
    let initProductionName: String = ProductionEnum.breakingBad.rawValue
    
    init(repo: BBRepo) {
        self.repo = repo
        Task {
            await getData(of: initProductionName)
        }
    }
    
    func getCharacter(characterName: String?) async throws {
        do {
            characterState = .loading
            let (data, httpResponse): ([CharacterModel], HTTPURLResponse) =
                try await repo.getCharacter(characterName ?? "")
            
            if httpResponse.statusCode == 200 {
                character = data.first
                character = try await character?.copyWithDeath(
                    death: getDeath(of: character?.name ?? "")
                )
                characterState = .success
            } else {
                characterState = .failure(httpResponse.debugDescription)
            }
            
            print ("@@@@@@@ character state is \(characterState)")
            
        } catch {
            characterState = .failure(error.localizedDescription)
            print("❌ Request failed:", error)
        }
    }
    
    func getRandomQuote(productionName: String) async throws {
        do {
            quoteState = .loading

            let (data, httpResponse): (QuoteModel, HTTPURLResponse) = try await repo.getRandomQuote(from: productionName)
            
            if httpResponse.statusCode == 200 {
                quote = data
                quoteState = .success
            } else {
                quoteState = .failure(httpResponse.debugDescription)
            }
            print ("@@@@@@@ quote state is \(quoteState)")

        } catch {
            quoteState = .failure(error.localizedDescription)

            print("❌ Request failed:", error)
        }
    }

    func getDeath(of characterName: String) async throws -> DeathModel? {
        do {

            let (data, httpResponse): ([DeathModel], HTTPURLResponse) = try await repo.getDeath()
            
            if httpResponse.statusCode == 200 {

                if let deathInfo = data.first(where: { death in death.character?.lowercased().contains(characterName.lowercased()) == true }) {
                    return deathInfo
                }
            }
            
        } catch {
            print("❌ Request failed:", error)
        }
        return nil
    }
    
    func getData(of productionName: String) async {
        
        do {
            try await getRandomQuote(productionName: productionName)
            try await getCharacter(characterName: quote?.character)
        } catch {
            print("❌ Request failed:", error)
        }
    }
}
