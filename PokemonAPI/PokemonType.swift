//
//  PokemonType.swift
//  PokemonAPI
//
//  Created by Cormell, David - DPC on 22/03/2023.
//

import Foundation

struct PokemonType: Codable, Hashable {
    var slot: Int
    var name: String
    var url: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        slot = try container.decode(Int.self, forKey: .slot)
        let type = try container.nestedContainer(keyedBy: TypeCodingKeys.self, forKey: .type)
        name = try type.decode(String.self, forKey: .name)
        url = try type.decode(String.self, forKey: .url)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(slot, forKey: .slot)

        var type = container.nestedContainer(keyedBy: TypeCodingKeys.self, forKey: .type)
        try type.encode(name, forKey: .name)
        try type.encode(url, forKey: .url)
    }
    
    enum CodingKeys: String, CodingKey {
        case slot, type
    }
    
    enum TypeCodingKeys: String, CodingKey {
        case name, url
    }
}
