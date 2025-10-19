//
//  HomeViewModel.swift
//  BBQuotes
//
//  Created by Moataz on 19/10/2025.
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var character: CharacterModel?
    
    private let repo: BBRepo
    
    init(repo: BBRepo) {
        self.repo = repo
        isLoading = true
        Task {
            await getCharacter()
        }
    }
    
    func getCharacter() async {
        do {
            let response: [CharacterModel] = try await repo.getCharacter("Walter White")
            character = response.first
            isLoading = false
            
        } catch {
            print("❌ Request failed:", error)
        }
    }
}
