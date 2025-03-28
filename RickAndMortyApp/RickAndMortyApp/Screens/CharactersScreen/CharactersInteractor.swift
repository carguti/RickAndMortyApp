//
//  CharactersInteractor.swift
//  RickAndMortyApp
//
//  Created by Carlos Gutiérrez Casado on 23/3/25.
//

import Foundation


class CharactersInteractor {
    @Inject var characterWebRepository: CharacterWebRepository
    
    @MainActor
    func getCharacters(nextPageURL: String? = nil) async throws -> CharacterResponse? {
        let dependencies = Dependencies.create(testMode: false)
        dependencies.initializeCharactersDependencies(testMode: false)
        
        let charactersResponse: CharacterResponse
        
        if let nextPageURL = nextPageURL {
            charactersResponse = try await characterWebRepository.getCharacters(nextPageURL: nextPageURL)
        } else {
            charactersResponse = try await characterWebRepository.getCharacters(nextPageURL: nil)
        }
        
        return charactersResponse
    }
    
    @MainActor
    func getCharactersWithFilterOptions(filterOptions: CharacterFilterOptions) async throws -> CharacterResponse? {
        let charactersResponse = try await characterWebRepository.getCharactersWithFilterOptions(filterOptions: filterOptions)
        
        return charactersResponse
    }
}

// Mock for CharactersInteractor
class MockCharactersInteractor: CharactersInteractor {
    var charactersToReturn: CharacterResponse?
    var errorToThrow: Error?

    override func getCharacters(nextPageURL: String? = nil) async throws -> CharacterResponse? {
        if let errorToThrow = errorToThrow {
            throw errorToThrow
        } else {
            charactersToReturn = CharacterResponse(info: ResponseInfo(count: 1, pages: 1, next: nil, prev: nil), results: [Mocks.mockCharacter])
            return charactersToReturn
        }
    }
}
