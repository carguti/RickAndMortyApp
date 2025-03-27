//
//  LocationDetailVM.swift
//  RickAndMortyApp
//
//  Created by Carlos Gutiérrez Casado on 26/3/25.
//

import Foundation

final class LocationDetailVM: NSObject, ObservableObject {
    private var locationDetailInteractor = LocationDetailInteractor()
    
    var characterResponse: CharacterResponse?
    @Published var characters: [Character] = []
    var namesString: String = ""
    
    // Default initializer (without parameters)
    override init() {
        self.locationDetailInteractor = LocationDetailInteractor()
        super.init()
    }
    
    // Initializer with a custom interactor (for testing)
    init(locationDetailInteractor: LocationDetailInteractor) {
        self.locationDetailInteractor = locationDetailInteractor
        super.init()
    }
    
    @MainActor
    func getCharacters(from location: Location) async throws {
        Task {
            characters = try await locationDetailInteractor.getMultiplesCharacters(charactersIds: extractResidentsIds(from: location.residents))
            namesString = getCharacterNamesString(from: characters)
        }
    }
    
    func extractResidentsIds(from urls: [String]) -> [Int] {
        return urls.compactMap { $0.extractCharacterNumber() }
    }
    
    func getCharacterNamesString(from characters: [Character]) -> String {
        let names = characters.map { $0.name }
        return names.joined(separator: ", ")
    }
    
}

