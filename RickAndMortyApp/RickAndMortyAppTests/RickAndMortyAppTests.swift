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
    func testGetCharactersSuccess() async {
        let mockCharacter = Character(id: 1, name: "Rick Sanchez", status: .alive, species: "Human", type: "", gender: "Male", origin: Origin(name: "Earth", url: ""), location: Location(name: "Earth", url: ""), image: "image_url", episode: [], url: "url", created: Date())
        let mockResponse = CharacterResponse(info: ResponseInfo(count: 1, pages: 1, next: nil, prev: nil), results: [mockCharacter])
        mockCharactersInteractor.mockResponse = mockResponse
        
        // When
        do {
            try await charactersVM.getCharacters()
            
            // Then
            XCTAssertEqual(charactersVM.characters.count, 1)
            XCTAssertEqual(charactersVM.characters.first?.name, "Rick Sanchez")
            XCTAssertFalse(charactersVM.isLoading)
        } catch {
            XCTFail("Expected success, but got error: \(error)")
        }
    }
    
    // Test getCharacters() with a failure response
    func testGetCharactersFailure() async {
        // Given
        mockCharactersInteractor.shouldThrowError = true
        
        // When
        do {
            try await charactersVM.getCharacters()
            XCTFail("Expected error, but got success.")
        } catch {
            // Then
            XCTAssertEqual(error.localizedDescription, "Mock error")
        }
    }
    
    func testGetCharactersNoData() async {
        // Given
        mockCharactersInteractor.mockResponse = nil
        
        // When
        do {
            try await charactersVM.getCharacters()
            
            // Then
            XCTAssertTrue(charactersVM.characters.isEmpty)
        } catch {
            XCTFail("Expected success, but got error: \(error)")
        }
    }
    
    // Test the filterCharacters() method
    func testFilterCharacters() {
        // Given
        let character1 = Character(id: 1, name: "Rick Sanchez", status: .alive, species: "Human", type: "", gender: "Male", origin: Origin(name: "Earth", url: ""), location: Location(name: "Earth", url: ""), image: "image_url", episode: [], url: "url", created: Date())
        let character2 = Character(id: 2, name: "Morty Smith", status: .alive, species: "Human", type: "", gender: "Male", origin: Origin(name: "Earth", url: ""), location: Location(name: "Earth", url: ""), image: "image_url", episode: [], url: "url", created: Date())
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
        let character1 = Character(id: 1, name: "Rick Sanchez", status: .alive, species: "Human", type: "", gender: "Male", origin: Origin(name: "Earth", url: ""), location: Location(name: "Earth", url: ""), image: "image_url", episode: [], url: "url", created: Date())
        charactersVM.characters = [character1]
        
        // When
        let filteredCharacters = charactersVM.filterCharacters(searchText: "Morty")
        
        // Then
        XCTAssertTrue(filteredCharacters.isEmpty)
    }
}
