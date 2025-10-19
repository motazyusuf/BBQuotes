//
//  QuoteModel.swift
//  BBQuotes
//
//  Created by Moataz on 18/10/2025.
//

import Foundation

struct QuoteModel: Decodable {
    let quote: String?
    let character: String?
    
 
    
    init(from decoder: Decoder) throws {
        let json = try decoder.container(keyedBy: DynamicCodingKey.self)
        quote = json.safeStringDecode(forKey: "quote")
        character = json.safeStringDecode(forKey: "character")
    }

    
}
