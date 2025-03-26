//
//  LocationsWebRepository.swift
//  RickAndMortyApp
//
//  Created by Carlos Gutiérrez Casado on 26/3/25.
//

import Foundation

protocol LocationsWebRepository: WebRepository {
    func getLocations(nextPageURL: String?) async throws -> LocationResponse
    func getSingleLocation(locationId: Int) async throws -> Location
    func getLocationsWithFilterOptions(filterOptions: LocationsFilterOptions) async throws -> LocationResponse
}

struct RealLocationsWebRepository: LocationsWebRepository {
    let session: URLSession
    let baseURL: String
    
    init(session: URLSession, baseUrl: String) {
        self.session = session
        self.baseURL = baseUrl
    }
    
    // Get locations
    func getLocations(nextPageURL: String? = nil) async throws -> LocationResponse {
        return try await call(endpoint: API.getLocations(nextPageURL: nextPageURL))
    }
    
    // Get locations with filter options
    func getLocationsWithFilterOptions(filterOptions: LocationsFilterOptions) async throws -> LocationResponse {
        return try await call(endpoint: API.getLocationsWithFilterOptions(filterOptions: filterOptions))
    }
    
    //Get single location
    func getSingleLocation(locationId: Int) async throws -> Location {
        return try await call(endpoint: API.getSingleLocation(id: locationId))
    }
}

struct MockLocationsWebRepository: LocationsWebRepository {
    let session: URLSession = .mockedResponsesOnly
    let baseURL = "https://test.com"
    
    func getLocations(nextPageURL: String? = nil) async throws -> LocationResponse {
        var locationResponesMock: LocationResponse {
            let mockInfo = ResponseInfo(count: 1, pages: 1, next: nil, prev: nil)
            return LocationResponse(info: mockInfo, results: [Mocks.mockLocation])
        }
        
        return locationResponesMock
    }
    
    func getLocationsWithFilterOptions(filterOptions: LocationsFilterOptions) async throws -> LocationResponse {
        var locationResponesMock: LocationResponse {
            let mockInfo = ResponseInfo(count: 1, pages: 1, next: nil, prev: nil)
            return LocationResponse(info: mockInfo, results: [Mocks.mockLocation])
        }
        
        return locationResponesMock
    }
    
    func getSingleLocation(locationId: Int) async throws -> Location {
        return Mocks.mockLocation
    }
}

extension RealLocationsWebRepository {
    enum API {
        case getLocations(nextPageURL: String?)
        case getLocationsWithFilterOptions(filterOptions: LocationsFilterOptions)
        case getSingleLocation(id: Int)
    }
}

extension RealLocationsWebRepository.API: APICall {
    var path: String {
        switch self {
        case .getLocations(var nextPage):
            guard let nextPage = nextPage else {
                return "?page=1"
            }
            
            return "?page=\(nextPage.extractPageNumber() ?? 1)"
        case .getLocationsWithFilterOptions(let filterOptions):
            return "?\(filterOptions.locationQueryString)"
        case .getSingleLocation(let id):
            return "/\(id)"
        }
    }
        
    var method: HTTPMethod {
        switch self {
        case .getLocations:
            return .get
        case .getLocationsWithFilterOptions:
            return .get
        case .getSingleLocation:
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
        case .getLocations:
            return nil
        case .getLocationsWithFilterOptions:
            return nil
        case .getSingleLocation:
            return nil
        }
    }
}
