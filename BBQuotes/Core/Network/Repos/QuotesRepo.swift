//
//  QuotesRepo.swift
//  BBQuotes
//
//  Created by Moataz on 19/10/2025.
//

import Foundation

struct BBRepo {
    
    
    func getRandomQuote(from show: String) async throws -> QuoteModel {
        
        let quote = try await NetworkHelper.request(
            url: Api.quotes,
            method: .get,
            queryParams: [URLQueryItem(name: "production", value: show)],
            responseType: QuoteModel.self,
        )
        
        return quote

    }
    
    func getCharacter(_ name: String) async throws -> [CharacterModel] {
        
        let characters = try await NetworkHelper.request(
            url: Api.characters,
            method: .get,
            queryParams: [URLQueryItem(name: "name", value: name)],
            responseType: [CharacterModel].self,
        )
        
        return characters
        
    }
    
    func getDeath(of name: String) async throws -> DeathModel {
        
        let death = try await NetworkHelper.request(
            url: Api.characters,
            method: .get,
            queryParams: [URLQueryItem(name: "name", value: name)],
            responseType: DeathModel.self,
        )
        
        return death
        
    }
}
