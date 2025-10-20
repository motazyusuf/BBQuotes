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
    
 
    enum CodingKeys: CodingKey {
        case quote
        case character
    }
    
    init(from decoder: Decoder) throws {
        let json = try decoder.container(keyedBy: CodingKeys.self)
        quote = json.safeStringDecode(forKey: .quote)
        character = json.safeStringDecode(forKey: .character)
    }

    
}
