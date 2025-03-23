//
//  BaseApiWebRepository.swift
//  RickAndMortyApp
//
//  Created by Carlos Gutiérrez Casado on 23/3/25.
//

import Foundation

protocol BaseApiWebRepository: WebRepository {
    func getBaseApi() async throws -> BaseApi
}

struct RealBaseApiWebRepository: BaseApiWebRepository {
    let session: URLSession
    let baseURL: String
    
    init(session: URLSession, baseUrl: String) {
        self.session = session
        self.baseURL = baseUrl
    }
    
    func getBaseApi() async throws -> BaseApi {
        return try await call(endpoint: API.baseApi)
    }
}

struct MockBaseApiWebRepository: BaseApiWebRepository {
    let session: URLSession = .mockedResponsesOnly
    let baseURL = "https://test.com"
    
    func getBaseApi() async throws -> BaseApi {
        return BaseApi(characters: "https://rickandmortyapi.com/api/character", locations: "https://rickandmortyapi.com/api/location", episodes: "https://rickandmortyapi.com/api/episode")
    }
}

extension RealBaseApiWebRepository {
    enum API {
        case baseApi
    }
}

extension RealBaseApiWebRepository.API: APICall {
    var path: String {
        switch self {
        case .baseApi:
            return ""
        }
    }
        
    var method: HTTPMethod {
        switch self {
        case .baseApi:
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
        case .baseApi:
            return nil
        }
    }
}

extension URLSession {
    static var mockedResponsesOnly: URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 1
        configuration.timeoutIntervalForResource = 1
        return URLSession(configuration: configuration)
    }
}


