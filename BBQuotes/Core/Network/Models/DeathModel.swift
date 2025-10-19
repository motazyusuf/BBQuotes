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
    
    
    init(from decoder: Decoder) throws {
        let json = try decoder.container(keyedBy: DynamicCodingKey.self)
        character = json.safeStringDecode(forKey: "character")
        image = json.safeURLDecode(forKey: "image")
        details = json.safeStringDecode(forKey: "details")
        lastWords = json.safeStringDecode(forKey: "last_words")
    }
}
