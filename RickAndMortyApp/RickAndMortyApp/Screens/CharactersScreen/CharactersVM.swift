//
//  CharactersVM.swift
//  RickAndMortyApp
//
//  Created by Carlos Gutiérrez Casado on 23/3/25.
//

import Foundation

final class CharactersVM: NSObject, ObservableObject {
    
    private let charactersInteractor = CharactersInteractor()
    
    var characterResponse: CharacterResponse?
    @Published var characters: [Character] = []
    @Published var isLoading = false
    
    @MainActor
    func getCharacters() async throws {
        isLoading = true
        defer { isLoading = false }
        
        Task {
            self.characterResponse = try await charactersInteractor.getCharacters()
            self.characters = characterResponse?.results ?? []
        }
        
    }
    
    func filterCharacters(searchText: String) -> [Character] {
        return self.characters.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }
}
