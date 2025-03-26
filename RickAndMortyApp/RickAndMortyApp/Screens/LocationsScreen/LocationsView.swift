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
    
    @State private var searchText: String = ""
    @State private var selectedLocation: Location?
    @State private var isSheetPresented = false
    var currentPage: Int = 1
    
    var filteredLocation: [Location] {
        if searchText.isEmpty {
            return locationsVM.locations
        } else {
            return locationsVM.filterLocations(searchText: searchText)
        }
    }
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    FloatingPlaceholderTextField(text: $searchText, placeholder: "Search location", isSearcheable: true)
                    
                    Spacer()
                    
                    Button(action: { isFilterPresented = true }) {
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
                            ListCell(location: location)
                        }
                        Color.clear
                            .onAppear {
                                locationsVM.fetchMoreLocations()
                            }
                        
                        Spacer()
                            .frame(height: 30)
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
                }, filterViewType: .location)
                .padding()
            }
        }
        .sheet(isPresented: Binding(
            get: { isSheetPresented && selectedLocation != nil },
            set: { isSheetPresented = $0 }
        )) {
            if let location = selectedLocation {
                LocationDetailView(location: location)
            }
        }
        .onAppear {
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
