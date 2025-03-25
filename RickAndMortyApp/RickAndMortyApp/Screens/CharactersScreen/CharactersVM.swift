//
//  CharactersVM.swift
//  RickAndMortyApp
//
//  Created by Carlos Gutiérrez Casado on 23/3/25.
//

import Foundation

final class CharactersVM: NSObject, ObservableObject {
    
    private var charactersInteractor = CharactersInteractor()
    
    var characterResponse: CharacterResponse?
    @Published var characters: [Character] = []
    @Published var isLoading = false
    
    // Default initializer (without parameters)
    override init() {
        self.charactersInteractor = CharactersInteractor() // Default interactor
        super.init()
    }
    
    // Initializer with a custom interactor (for testing)
    init(charactersInteractor: CharactersInteractor) {
        self.charactersInteractor = charactersInteractor
        super.init()
    }
    
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
    
    func fetchFilteredCharacters(with filterOptions: FilterOptions) {
        Task {
            do {
                let response = try await charactersInteractor.getCharactersWithFilterOptions(filterOptions: filterOptions)
                DispatchQueue.main.async {
                    self.characters = response?.results ?? []
                }
            } catch {
                print("Failed to fetch filtered characters: \(error)")
            }
        }
    }
}
