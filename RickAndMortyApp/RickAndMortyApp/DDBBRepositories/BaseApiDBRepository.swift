//
//  BaseApiDBRepository.swift
//  RickAndMortyApp
//
//  Created by Carlos Gutiérrez Casado on 23/3/25.
//

import Foundation

protocol BaseApiDBRepository {
    func store(baseApi: BaseApi?) throws
    func getBaseApi() throws -> BaseApi?
}

struct RealBaseApiDBRepository: BaseApiDBRepository {
    func store(baseApi: BaseApi?) throws {
        guard let baseApi = baseApi else {
            return
        }
        
        UserDefaults.standard.baseApi = baseApi
    }
    
    func getBaseApi() throws -> BaseApi? {
        return UserDefaults.standard.baseApi
    }
}

struct MockBaseApiDBRepository: BaseApiDBRepository {
    let storage = TestStorage(api: BaseApi(characters: "https://rickandmortyapi.com/api/character", locations: "https://rickandmortyapi.com/api/location", episodes: "https://rickandmortyapi.com/api/episode"))
    
    func store(baseApi: BaseApi?) throws {
        guard let baseApi = baseApi else {
            return
        }
        
        storage.store(apiData: baseApi)
    }
    
    func getBaseApi() throws -> BaseApi? {
        return storage.getData()
    }
}

class TestStorage {
    var api: BaseApi

    init(api: BaseApi) {
        self.api = api
    }
    
    func store(apiData: BaseApi) {
        self.api = apiData
    }
    
    func getData() -> BaseApi {
        return api
    }
    
    func getElement(type: String) -> String? {
        switch type.lowercased() {
        case "characters":
            return api.characters
        case "locations":
            return api.locations
        case "episodes":
            return api.episodes
        default:
            return nil
        }
    }
}
