//
//  CharactersInteractor.swift
//  RickAndMortyApp
//
//  Created by Carlos Gutiérrez Casado on 23/3/25.
//

import Foundation

class CharactersInteractor {
    @Inject var characterWebRepository: CharacterWebRepository
    
    func getCharacters() async throws -> CharacterResponse? {
        let charactersResponse = try await characterWebRepository.getCharacters()
        
        return charactersResponse
    }
    
    func getCharactersWithFilterOptions(filterOptions: FilterOptions) async throws -> CharacterResponse? {
        let charactersResponse = try await characterWebRepository.getCharactersWithFilterOptions(filterOptions: filterOptions)
        
        return charactersResponse
    }
}

// Mock for CharactersInteractor
class MockCharactersInteractor: CharactersInteractor {
    var mockResponse: CharacterResponse?
    var shouldThrowError = false
    
    override func getCharacters() async throws -> CharacterResponse? {
        if shouldThrowError {
            throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Mock error"])
        }
        return mockResponse
    }
}
