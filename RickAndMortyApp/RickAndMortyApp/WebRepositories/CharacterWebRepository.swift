//
//  CharacterWebRepository.swift
//  RickAndMortyApp
//
//  Created by Carlos Gutiérrez Casado on 23/3/25.
//

import Foundation

protocol CharacterWebRepository: WebRepository {
    func getCharacters(nextPageURL: String?) async throws -> CharacterResponse
    func getSingleCharacter(characterId: Int) async throws -> Character
    func getCharactersWithFilterOptions(filterOptions: CharacterFilterOptions) async throws -> CharacterResponse
    func getMultipleCharacters(charactersIds: [Int]) async throws -> [Character]
}

struct RealCharacterWebRepository: CharacterWebRepository {
    
    let session: URLSession
    let baseURL: String
    
    init(session: URLSession, baseUrl: String) {
        self.session = session
        self.baseURL = baseUrl
    }
    
    // Get characters
    func getCharacters(nextPageURL: String? = nil) async throws -> CharacterResponse {
        return try await call(endpoint: API.getCharacters(nextPageURL: nextPageURL))
    }
    
    // Get characters with filter options
    func getCharactersWithFilterOptions(filterOptions: CharacterFilterOptions) async throws -> CharacterResponse {
        return try await call(endpoint: API.getCharactersWithFilterOptions(filterOptions: filterOptions))
    }
    
    //Get single character
    func getSingleCharacter(characterId: Int) async throws -> Character {
        return try await call(endpoint: API.getSingleCharacter(id: characterId))
    }
    
    //Get multiple characters
    func getMultipleCharacters(charactersIds: [Int]) async throws -> [Character] {
        return try await call(endpoint: API.getMultipleCharacters(ids: charactersIds))
    }
}

struct MockCharacterWebRepository: CharacterWebRepository {
    let session: URLSession = .mockedResponsesOnly
    let baseURL = "https://test.com"
    
    func getCharacters(nextPageURL: String? = nil) async throws -> CharacterResponse {
        var characterResponesMock: CharacterResponse {
            let mockInfo = ResponseInfo(count: 1, pages: 1, next: nil, prev: nil)
            return CharacterResponse(info: mockInfo, results: [Mocks.mockCharacter])
        }
        
        return characterResponesMock
    }
    
    func getCharactersWithFilterOptions(filterOptions: CharacterFilterOptions) async throws -> CharacterResponse {
        var characterResponesMock: CharacterResponse {
            let mockInfo = ResponseInfo(count: 1, pages: 1, next: nil, prev: nil)
            return CharacterResponse(info: mockInfo, results: [Mocks.mockCharacter])
        }
        
        return characterResponesMock
    }
    
    func getSingleCharacter(characterId: Int) async throws -> Character {
        return Mocks.mockCharacter
    }
    
    func getMultipleCharacters(charactersIds: [Int]) async throws -> [Character] {
        return [Mocks.mockCharacter]
    }
}

extension RealCharacterWebRepository {
    enum API {
        case getCharacters(nextPageURL: String?)
        case getCharactersWithFilterOptions(filterOptions: CharacterFilterOptions)
        case getSingleCharacter(id: Int)
        case getMultipleCharacters(ids: [Int])
    }
}

extension RealCharacterWebRepository.API: APICall {
    var path: String {
        switch self {
        case .getCharacters(let nextPage):
            guard let nextPage = nextPage else {
                return "?page=1"
            }
            
            return "?page=\(nextPage.extractPageNumber() ?? 1)"
        case .getCharactersWithFilterOptions(let filterOptions):
            return "?\(filterOptions.queryString)"
        case .getSingleCharacter(let id):
            return "/\(id)"
        case .getMultipleCharacters(let charactersIds):
            return "/\(charactersIds)"
        }
    }
        
    var method: HTTPMethod {
        switch self {
        case .getCharacters:
            return .get
        case .getCharactersWithFilterOptions:
            return .get
        case .getSingleCharacter:
            return .get
        case .getMultipleCharacters:
            return .get
        }
    }
    
    func headers() throws -> [String: String]? {
        return [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
    }
        
    func body() throws -> Data? {
        switch self {
        case .getCharacters:
            return nil
        case .getCharactersWithFilterOptions:
            return nil
        case .getSingleCharacter:
            return nil
        case .getMultipleCharacters:
            return nil
        }
    }
}

