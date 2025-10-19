//
//  DeathEnum.swift
//  BBQuotes
//
//  Created by Moataz on 18/10/2025.
//

enum Status: String, Decodable {
    case dead = "dead"
    case alive = "alive"
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try? container.decode(String.self).lowercased()
        self = Status(rawValue: value ?? "") ?? .alive
    }
}
    
