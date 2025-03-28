//
//  Dependencies.swift
//  RickAndMortyApp
//
//  Created by Carlos Gutiérrez Casado on 23/3/25.
//

import Foundation

class Dependencies {
    private var kBaseUrl = "BaseURL"
    
    private var baseUrl: String {
        guard let baseURL = Bundle.string(for: InfoPlistKeys.kBaseURL) else {
            return ""
        }
        
        return baseURL
    }
    
    var session: URLSession {
        let configuration = URLSessionConfiguration.default
        
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 120
        configuration.waitsForConnectivity = true
        configuration.httpMaximumConnectionsPerHost = 5
        configuration.requestCachePolicy = .reloadIgnoringCacheData
        configuration.urlCache = .shared
        
        return URLSession(configuration: configuration)
    }
    
    // MARK: - Test data
    
    static var test: Dependencies {
        return Dependencies(testMode: true)
    }
    
    private init(testMode: Bool) {
        initializeBaseApiDependencies(testMode: testMode)
    }
        
    
    static func create(testMode: Bool) -> Dependencies {
        return Dependencies(testMode: testMode)
    }
    
    // MARK: - Base API Dependencies
    private func initializeBaseApiDependencies(testMode: Bool) {
        baseApiDependencies(testMode: testMode)
    }
    
    // MARK: - Feature-Specific Dependencies
    func initializeCharactersDependencies(testMode: Bool) {
        getCharactersDependencies(testMode: testMode)
    }
    
    // MARK: - Feature-Specific Dependencies
    func initializeLocationsDependencies(testMode: Bool) {
        getLocationsDependencies(testMode: testMode)
    }
}

// MARK: - BaseApi dependencie

extension Dependencies {
    private func baseApiDependencies(testMode: Bool = false) {
        if testMode {
            @Provider var baseApiWebRepository = MockBaseApiWebRepository() as BaseApiWebRepository
            @Provider var baseApiDDBBRepository = MockBaseApiDBRepository() as BaseApiDBRepository
        } else {
            @Provider var baseApiWebRepository = RealBaseApiWebRepository(session: session, baseUrl: baseUrl) as BaseApiWebRepository
            @Provider var baseApiDDBBRepository = RealBaseApiDBRepository() as BaseApiDBRepository
        }
    }
}

// MARK: - Characters dependencies

extension Dependencies {
    
    private func getCharactersDependencies(testMode: Bool = false) {
        @Inject var baseApiDBRepository: BaseApiDBRepository
        
        if testMode {
            @Provider var charactersWebRepository = MockCharacterWebRepository() as CharacterWebRepository
            //@Provider var baseApiDDBBRepository = MockCharacterRepository() as BaseApiDBRepository
        } else {
            Task {
                let charactersUrl = try baseApiDBRepository.getBaseApi()?.characters ?? UserDefaults.standard.baseApi?.characters
                
                @Provider var charactersWebRepository = RealCharacterWebRepository(session: session, baseUrl: charactersUrl ?? "") as CharacterWebRepository
            }
            
            //@Provider var baseApiDDBBRepository = RealCharacterDBRepository() as BaseApiDBRepository
        }
    }
}

// MARK: - Characters dependencies

extension Dependencies {
    
    private func getLocationsDependencies(testMode: Bool = false) {
        @Inject var baseApiDBRepository: BaseApiDBRepository
        
        if testMode {
            @Provider var baseApiWebRepository = MockLocationsWebRepository() as LocationsWebRepository
            //@Provider var baseApiDDBBRepository = MockCharacterRepository() as BaseApiDBRepository
        } else {
            Task {
                let locationsUrl = try baseApiDBRepository.getBaseApi()?.locations ?? UserDefaults.standard.baseApi?.locations
                
                @Provider var baseApiWebRepository = RealLocationsWebRepository(session: session, baseUrl: locationsUrl ?? "") as LocationsWebRepository
            }
            
            //@Provider var baseApiDDBBRepository = RealCharacterDBRepository() as BaseApiDBRepository
        }
    }
}
