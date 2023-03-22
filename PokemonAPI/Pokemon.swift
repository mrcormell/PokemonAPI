//
//  Pokemon.swift
//  PokemonAPI
//
//  Created by Cormell, David - DPC on 22/03/2023.
//

import Foundation

struct Pokemon: Codable {
    var height: Int
    var weight: Int
    var types: [PokemonType]
}
