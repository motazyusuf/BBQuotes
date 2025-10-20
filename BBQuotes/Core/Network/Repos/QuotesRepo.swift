//
//  QuotesRepo.swift
//  BBQuotes
//
//  Created by Moataz on 19/10/2025.
//

import Foundation

struct BBRepo {
    
    
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
