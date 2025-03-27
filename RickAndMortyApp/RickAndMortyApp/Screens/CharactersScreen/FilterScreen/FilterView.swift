//
//  FilterView.swift
//  RickAndMortyApp
//
//  Created by Carlos Gutiérrez Casado on 24/3/25.
//

import SwiftUI

enum FilterViewType {
    case character
    case location
}

struct FilterView: View {
    @Binding var characterFilterOptions: CharacterFilterOptions
    @Binding var locationsFilterOptions: LocationsFilterOptions
    @Binding var isPresented: Bool
    var applyFilter: () -> Void
    var cancelFilter: () -> Void
    var filterViewType: FilterViewType
    
    var body: some View {
        VStack(spacing: 40) {
            Text(filterViewType == .character ? "FILTER_CHARACTERS".localized : "FILTER_LOCATIONS".localized)
                .font(.title)
                .bold()

            if filterViewType == .character {
                characterFilterView
            } else {
                locationFilterView
            }

            actionButtons
        }
        .padding(.top, 24)
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 10)
    }
}

// MARK: - Character Filter View
extension FilterView {
    @ViewBuilder
    var characterFilterView: some View {
        FloatingPlaceholderTextField(text: $characterFilterOptions.name, placeholder: "NAME".localized, isSearcheable: false)
            .frame(height: 40)

        HStack {
            Text("STATUS".localized)
            
            statusPicker(selection: $characterFilterOptions.status)
        }
        .padding()
        
        FloatingPlaceholderTextField(text: $characterFilterOptions.species, placeholder: "CHARACTERS_SPECIES".localized, isSearcheable: false)
            .frame(height: 40)

        FloatingPlaceholderTextField(text: $characterFilterOptions.type, placeholder: "TYPE".localized, isSearcheable: false)
            .frame(height: 40)

        HStack {
            Text("GENDER".localized)
            
            genderPicker(selection: $characterFilterOptions.gender)
        }
        .padding()
        
    }
}

// MARK: - Location Filter View
extension FilterView {
    @ViewBuilder
    var locationFilterView: some View {
        FloatingPlaceholderTextField(text: $locationsFilterOptions.name, placeholder: "NAME".localized, isSearcheable: false)
            .frame(height: 40)

        FloatingPlaceholderTextField(text: $locationsFilterOptions.type, placeholder: "TYPE".localized, isSearcheable: false)
            .frame(height: 40)

        FloatingPlaceholderTextField(text: $locationsFilterOptions.dimension, placeholder: "LOCATIONS_DIMENSION".localized, isSearcheable: false)
            .frame(height: 40)
    }
}

// MARK: - Picker Views
extension FilterView {
    @ViewBuilder
    func statusPicker(selection: Binding<String>) -> some View {
        Picker(selection: selection, label: Text(selection.wrappedValue.isEmpty ? "Select Status" : selection.wrappedValue)) {
            Text("ALL".localized).tag("")
            Text("CHARACTERS_ALIVE".localized).tag("alive")
            Text("CHARACTERS_DEAD".localized).tag("dead")
            Text("UNKNOWN".localized).tag("unknown")
        }
        .pickerStyle(MenuPickerStyle())
        .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder
    func genderPicker(selection: Binding<String>) -> some View {
        Picker(selection: selection, label: Text(selection.wrappedValue.isEmpty ? "Select Gender" : selection.wrappedValue)) {
            Text("ALL".localized).tag("")
            Text("CHARACTER_FEMALE".localized).tag("female")
            Text("CHARACTER_MALE".localized).tag("male")
            Text("CHARACTER_GENDERLESS".localized).tag("genderless")
            Text("UNKNOWN".localized).tag("unknown")
        }
        .pickerStyle(MenuPickerStyle())
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Action Buttons
extension FilterView {
    var actionButtons: some View {
        HStack(spacing: 24) {
            Spacer()

            Button("APPLY".localized) {
                applyFilter()
                isPresented = false
            }
            .foregroundColor(.white)
            .frame(height: 40)
            .frame(maxWidth: .infinity)
            .background(Color.black)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.white, lineWidth: 1)
            )
            
            Button("CANCEL".localized) {
                cancelFilter()
                isPresented = false
            }
            .foregroundColor(.black)
            .padding()
            .frame(height: 40)
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.black, lineWidth: 1)
            )

            Spacer()
        }
        .padding()
    }
}

#Preview {
    FilterView(
        characterFilterOptions: .constant(CharacterFilterOptions()),
        locationsFilterOptions: .constant(LocationsFilterOptions()),
        isPresented: .constant(true),
        applyFilter: {}, cancelFilter: {},
        filterViewType: .character
    )
}
