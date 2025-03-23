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
