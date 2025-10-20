//
//  Untitled.swift
//  BBQuotes
//
//  Created by Moataz on 18/10/2025.
//

import Foundation

struct DeathModel: Decodable {
    let character: String?
    let image: URL?
    let details: String?
    let lastWords: String?
    
    enum CodingKeys: CodingKey {
        case character
        case image
        case details
        case lastWords
    }
    
    init(from decoder: Decoder) throws {
        let json = try decoder.container(keyedBy: CodingKeys.self)
        character = json.safeStringDecode(forKey: .character)
        image = json.safeURLDecode(forKey: .image)
        details = json.safeStringDecode(forKey: .details)
        lastWords = json.safeStringDecode(forKey: .lastWords)
    }
}
