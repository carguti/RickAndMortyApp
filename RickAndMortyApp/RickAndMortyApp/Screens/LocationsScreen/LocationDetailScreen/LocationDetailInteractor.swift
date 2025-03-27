//
//  LocationDetailInteractor.swift
//  RickAndMortyApp
//
//  Created by Carlos Gutiérrez Casado on 26/3/25.
//

import Foundation

class LocationDetailInteractor {
    @Inject var characterWebRepository: CharacterWebRepository
    
    func getMultiplesCharacters(charactersIds: [Int]) async throws -> [Character] {
        let charactersResponse = try await characterWebRepository.getMultipleCharacters(charactersIds: charactersIds)
        
        return charactersResponse
    }
}
