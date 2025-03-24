//
//  Constants.swift
//  RickAndMortyApp
//
//  Created by Carlos Gutiérrez Casado on 23/3/25.
//

import Foundation

struct InfoPlistKeys {
    static let kBaseURL = "BaseURL"
}

struct Mocks {
    static let mockCharacter = Character(
        id: 1,
        name: "Rick Sanchez",
        status: .alive,
        species: "Human",
        type: "",
        gender: "Male",
        origin: Origin(name: "Earth", url: "https://rickandmortyapi.com/api/location/1"),
        location: Location(name: "Earth", url: "https://rickandmortyapi.com/api/location/20"),
        image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
        episode: ["https://rickandmortyapi.com/api/episode/1", "https://rickandmortyapi.com/api/episode/2"],
        url: "https://rickandmortyapi.com/api/character/1",
        created: Date()
    )
}
