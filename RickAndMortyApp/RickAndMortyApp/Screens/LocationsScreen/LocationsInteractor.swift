//
//  LocationsInteractor.swift
//  RickAndMortyApp
//
//  Created by Carlos Gutiérrez Casado on 26/3/25.
//

import Foundation

class LocationsInteractor {
    @Inject var locationsrWebRepository: LocationsWebRepository
    
    func getLocations(nextPageURL: String? = nil) async throws -> LocationResponse? {
        let locationResponse: LocationResponse
        
        if let nextPageURL = nextPageURL {
            locationResponse = try await locationsrWebRepository.getLocations(nextPageURL: nextPageURL)
        } else {
            locationResponse = try await locationsrWebRepository.getLocations(nextPageURL: nil)
        }
        
        return locationResponse
    }
    
    func getLocationsWithFilterOptions(filterOptions: LocationsFilterOptions) async throws -> LocationResponse? {
        let locationResponse = try await locationsrWebRepository.getLocationsWithFilterOptions(filterOptions: filterOptions)
        
        return locationResponse
    }
}

// Mock for LocationsInteractor
class MockLocationsInteractor: LocationsInteractor {
    var mockResponse: LocationResponse?
    var shouldThrowError = false
    
    override func getLocations(nextPageURL: String? = nil) async throws -> LocationResponse? {
        if shouldThrowError {
            throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Mock error"])
        }
        return mockResponse
    }
}
