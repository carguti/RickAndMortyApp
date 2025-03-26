//
//  LocationsVM.swift
//  RickAndMortyApp
//
//  Created by Carlos Gutiérrez Casado on 26/3/25.
//

import Foundation

final class LocationsVM: NSObject, ObservableObject {
    
    private var locationsInteractor = LocationsInteractor()
    
    var locationResponse: LocationResponse?
    @Published var locations: [Location] = []
    @Published var isLoading = false
    
    // Default initializer (without parameters)
    override init() {
        self.locationsInteractor = LocationsInteractor() // Default interactor
        super.init()
    }
    
    // Initializer with a custom interactor (for testing)
    init(locationsInteractor: LocationsInteractor) {
        self.locationsInteractor = locationsInteractor
        super.init()
    }
    
    @MainActor
    func getLocations() async throws {
        isLoading = true
        defer { isLoading = false }
        
        Task {
            self.locationResponse = try await locationsInteractor.getLocations()
            self.locations = locationResponse?.results ?? []
        }
        
    }
    
    @MainActor
    func fetchMoreLocations() {
        guard !isLoading, hasMoreResults else { return }
        isLoading = true
        
        Task {
            guard let locationResponse = locationResponse else { return }
            
            do {
                guard let newResponse = try await locationsInteractor.getLocations(nextPageURL: locationResponse.info.next) else { return }
                self.locationResponse = newResponse
                self.locations.append(contentsOf: newResponse.results)
                isLoading = false
            } catch {
                print("Error loading more locations: \(error)")
                isLoading = false
            }
        }
    }
    
    func filterLocations(searchText: String) -> [Location] {
        return self.locations.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }
    
    func fetchFilteredLocations(with filterOptions: LocationsFilterOptions) {
        Task {
            do {
                let response = try await locationsInteractor.getLocationsWithFilterOptions(filterOptions: filterOptions)
                DispatchQueue.main.async {
                    self.locations = response?.results ?? []
                }
            } catch {
                print("Failed to fetch filtered locations: \(error)")
            }
        }
    }
    
    var hasMoreResults: Bool {
        locationResponse?.info.next != nil
    }
}
