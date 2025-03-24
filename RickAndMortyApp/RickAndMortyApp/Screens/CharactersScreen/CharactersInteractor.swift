//
//  CharactersInteractor.swift
//  RickAndMortyApp
//
//  Created by Carlos Gutiérrez Casado on 23/3/25.
//

import Foundation

final class CharactersInteractor {
    @Inject var characterWebRepository: CharacterWebRepository
    
    func getCharacters() async throws -> CharacterResponse? {
        let charactersResponse = try await characterWebRepository.getCharacters()
        
        return charactersResponse
    }
}
