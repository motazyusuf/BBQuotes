//
//  CharacterModel.swift
//  BBQuotes
//
//  Created by Moataz on 18/10/2025.
//

import Foundation




struct CharacterModel: Decodable, Equatable {
    let name: String?
    let birthday: String?
    let occupations: [String]?
    let images: [URL]?
    let aliases: [String]?
    let status: Status?
    let portrayedBy: String?
    var death: DeathModel?
    
    
    enum CodingKeys: CodingKey {
        case name
        case birthday
        case occupation
        case images
        case aliases
        case status
        case portrayedBy
        case death
    }
    
    init(from decoder: Decoder) throws {
        let json = try decoder.container(keyedBy: CodingKeys.self)
        name = json.safeStringDecode(forKey: .name)
        birthday = json.safeStringDecode(forKey: .birthday)
        occupations = json.safeListDecode(forKey: .occupation)
        images = json.safeListDecode(forKey: .images)
        aliases = json.safeListDecode(forKey: .aliases)
        portrayedBy = json.safeStringDecode(forKey: .portrayedBy)
        status = json.safeObjectDecode(forKey: .status)
    }
    
    init(
        name: String? = nil,
        birthday: String? = nil,
        occupations: [String]? = nil,
        images: [URL]? = nil,
        aliases: [String]? = nil,
        status: Status? = nil,
        portrayedBy: String? = nil,
        death: DeathModel? = nil
    )
    {
        self.name = name
        self.birthday = birthday
        self.occupations = occupations
        self.images = images
        self.aliases = aliases
        self.status = status
        self.portrayedBy = portrayedBy
        self.death = death
    }

    
    func copyWithDeath(death: DeathModel?) -> CharacterModel {
        var copy = self
        copy.death = death
        return copy
    }
    
    
}

