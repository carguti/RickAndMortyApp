//
//  LocationsView.swift
//  RickAndMortyApp
//
//  Created by Carlos Gutiérrez Casado on 23/3/25.
//

import SwiftUI

struct LocationsView: View {
    
    @StateObject var locationsVM = LocationsVM()
    @State private var charactersFilterOptions = CharacterFilterOptions()
    @State private var locationsFilterOptions = LocationsFilterOptions()
    @State private var isFilterPresented = false
    @State private var filteredResults = false
    
    @State private var searchText: String = ""
    @State private var selectedLocation: Location?
    @State private var isSheetPresented = false
    var currentPage: Int = 1
    
    @State private var expandedLocationId: Int?
    
    var filteredLocation: [Location] {
        if searchText.isEmpty {
            return locationsVM.locations
        } else {
            return locationsVM.filterLocations(searchText: searchText)
        }
    }
    
    init() {
        let dependencies = Dependencies.create(testMode: false)
        dependencies.initializeLocationsDependencies(testMode: false)
    }
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    FloatingPlaceholderTextField(text: $searchText, placeholder: "SEARCH_LOCATIONS".localized, isSearcheable: true)
                    
                    Spacer()
                    
                    Button(action: {
                        isFilterPresented = true
                        filteredResults = true
                        
                    }) {
                        Image(systemName: "line.horizontal.3.decrease.circle")
                            .imageScale(.large)
                            .foregroundColor(.black)
                            .frame(width: 30)
                    }
                }
                .padding(.horizontal, 24)
                
                
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 12) {
                        ForEach(filteredLocation) { location in
                            ListCell(location: location, expandedLocationId: $expandedLocationId)
                        }
                        Color.clear
                            .onAppear {
                                if !filteredResults {
                                    locationsVM.fetchMoreLocations()
                                }
                            }
                        
                        Spacer()
                            .frame(height: 10)
                    }
                    .padding(.horizontal, 24)
                }
            }
            .padding(.vertical, 40)
            
            
            if isFilterPresented {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture { isFilterPresented = false }
                
                FilterView(characterFilterOptions: $charactersFilterOptions, locationsFilterOptions: $locationsFilterOptions, isPresented:  $isFilterPresented, applyFilter: {
                    locationsVM.fetchFilteredLocations(with: locationsFilterOptions)
                }, cancelFilter: {
                    filteredResults = false
                    Task {
                        try await locationsVM.getLocations()
                    }
                }, filterViewType: .location)
                .padding()
            }
        }
        .onAppear {
            filteredResults = false
            Task {
                try await locationsVM.getLocations()
            }
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
}

#Preview {
    LocationsView()
}
