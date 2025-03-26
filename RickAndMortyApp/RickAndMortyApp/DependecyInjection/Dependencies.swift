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
        baseApiDependencies(testMode: testMode)
        getCharactersDependencies(testMode: testMode)
        getLocationsDependencies(testMode: testMode)
    }
    
    static func create(testMode: Bool) -> Dependencies {
        return Dependencies(testMode: testMode)
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
            @Provider var baseApiWebRepository = MockCharacterWebRepository() as CharacterWebRepository
            //@Provider var baseApiDDBBRepository = MockCharacterRepository() as BaseApiDBRepository
        } else {
            Task {
                guard let charactersUrl = try baseApiDBRepository.getBaseApi()?.characters else {
                    return
                }
                
                @Provider var baseApiWebRepository = RealCharacterWebRepository(session: session, baseUrl: charactersUrl) as CharacterWebRepository
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
                guard let locationsUrl = try baseApiDBRepository.getBaseApi()?.locations else {
                    return
                }
                
                @Provider var baseApiWebRepository = RealLocationsWebRepository(session: session, baseUrl: locationsUrl) as LocationsWebRepository
            }
            
            //@Provider var baseApiDDBBRepository = RealCharacterDBRepository() as BaseApiDBRepository
        }
    }
}
