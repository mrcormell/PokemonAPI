//
//  ContentView.swift
//  PokemonAPI
//
//  Created by Cormell, David - DPC on 22/03/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var pokemon: Pokemon?
    @State private var pokemonName: String = ""
    
    var body: some View {
        Form {
            Section {
                TextField("Enter Pokemon Name: ", text: $pokemonName)
                Button("Get Pokemon Stats") {
                    Task {
                        await loadData()
                    }
                }
            }

            if let pokemon = pokemon {
                Section {
                    Text("Height is: \(pokemon.height)")
                    ForEach(pokemon.types, id: \.self) {
                        Text("\($0.name)")
                    }
                }
            }
        }

    }
    
    func loadData() async {
        let stringUrl = "https://pokeapi.co/api/v2/pokemon/\(pokemonName.lowercased())"
        guard let url = URL(string: stringUrl) else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            if let decodedResponse = try? JSONDecoder().decode(Pokemon.self, from: data) {
                DispatchQueue.main.async {
                    pokemon = decodedResponse
                }
            }
        } catch {
            print("Invalid data")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
