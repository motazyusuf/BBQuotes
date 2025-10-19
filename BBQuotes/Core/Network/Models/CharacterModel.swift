//
//  CharacterModel.swift
//  BBQuotes
//
//  Created by Moataz on 18/10/2025.
//

import Foundation




struct CharacterModel: Decodable {
    let name: String?
    let birthday: String?
    let occupations: [String]?
    let images: [URL]?
    let aliases: [String]?
    let status: Status?
    let portrayedBy: String?
    var death: DeathModel?
    
    init(from decoder: Decoder) throws {
        let json = try decoder.container(keyedBy: DynamicCodingKey.self)
        name = json.safeStringDecode(forKey: "name")
        birthday = json.safeStringDecode(forKey: "birthday")
        occupations = json.safeListDecode(forKey: "occupation")
        images = json.safeListDecode(forKey: "images")
        aliases = json.safeListDecode(forKey: "aliases")
        portrayedBy = json.safeStringDecode(forKey: "portrayed_by")
        status = json.safeObjectDecode(forKey: "status")
    }
}

