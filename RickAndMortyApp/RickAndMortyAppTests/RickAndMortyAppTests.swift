//
//  RickAndMortyAppTests.swift
//  RickAndMortyAppTests
//
//  Created by Carlos Gutiérrez Casado on 22/3/25.
//

import XCTest
@testable import RickAndMortyApp

class CharactersVMTests: XCTestCase {
    
    var charactersVM: CharactersVM!
    var mockCharactersInteractor: MockCharactersInteractor!
    
    override func setUp() {
        super.setUp()
        mockCharactersInteractor = MockCharactersInteractor()
        charactersVM = CharactersVM()
        
        charactersVM = CharactersVM(charactersInteractor: mockCharactersInteractor)
    }
    
    override func tearDown() {
        charactersVM = nil
        mockCharactersInteractor = nil
        super.tearDown()
    }
    
    // Test getCharacters() with a successful response
    func testGetCharactersSuccess() async throws {
        // Given
        let mockResponse = CharacterResponse(info: ResponseInfo(count: 1, pages: 1, next: nil, prev: nil), results: [
            Character(id: 1, name: "Rick Sanchez", status: .alive, species: "Human", type: "Human", gender: "Male", origin: Origin(name: "Earth", url: "testUrl"), location: CharacterLocation(name: "Earth", url: "testUrl"), image: "image_url", episode: [""], url: "testUrl", created: Date())
        ])
        
        // Setting up the mock response
        mockCharactersInteractor.charactersToReturn = mockResponse
        
        // When
        try await charactersVM.getCharacters()
        
        // Then
        XCTAssertFalse(charactersVM.isLoading)
        XCTAssertEqual(charactersVM.characters.count, 1)
        XCTAssertEqual(charactersVM.characters.first?.name, "Rick Sanchez")
    }
    
    // Test getCharacters() with a failure response
    func testGetCharactersFailure() async throws {
        // Given
        let expectedError = NSError(domain: "TestError", code: 1, userInfo: nil)
        mockCharactersInteractor.errorToThrow = expectedError
        
        // When
        do {
            try await charactersVM.getCharacters()
            XCTFail("Expected error to be thrown")
        } catch {
            // Then
            XCTAssertTrue(charactersVM.isLoading)
        }
    }
    
    // Test the filterCharacters() method
    func testFilterCharacters() {
        // Given
        let character1 = Character(id: 1, name: "Rick Sanchez", status: .alive, species: "Human", type: "", gender: "Male", origin: Origin(name: "Earth", url: ""), location: CharacterLocation(name: "Earth", url: ""), image: "image_url", episode: [], url: "url", created: Date())
        let character2 = Character(id: 2, name: "Morty Smith", status: .alive, species: "Human", type: "", gender: "Male", origin: Origin(name: "Earth", url: ""), location: CharacterLocation(name: "Earth", url: ""), image: "image_url", episode: [], url: "url", created: Date())
        charactersVM.characters = [character1, character2]
        
        // When
        let filteredCharacters = charactersVM.filterCharacters(searchText: "Rick")
        
        // Then
        XCTAssertEqual(filteredCharacters.count, 1)
        XCTAssertEqual(filteredCharacters.first?.name, "Rick Sanchez")
    }
    
    // Test filterCharacters() when no characters match
    func testFilterCharactersNoMatch() {
        // Given
        let character1 = Character(id: 1, name: "Rick Sanchez", status: .alive, species: "Human", type: "", gender: "Male", origin: Origin(name: "Earth", url: ""), location: CharacterLocation(name: "Earth", url: ""), image: "image_url", episode: [], url: "url", created: Date())
        charactersVM.characters = [character1]
        
        // When
        let filteredCharacters = charactersVM.filterCharacters(searchText: "Morty")
        
        // Then
        XCTAssertTrue(filteredCharacters.isEmpty)
    }
}
