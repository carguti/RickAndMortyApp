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
    var filterViewType: FilterViewType
    
    var body: some View {
        VStack(spacing: 40) {
            Text(filterViewType == .character ? "Filter Characters" : "Filter Locations")
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
        FloatingPlaceholderTextField(text: $characterFilterOptions.name, placeholder: "Name", isSearcheable: false)
            .frame(height: 40)

        statusPicker(selection: $characterFilterOptions.status)

        FloatingPlaceholderTextField(text: $characterFilterOptions.species, placeholder: "Species", isSearcheable: false)
            .frame(height: 40)

        FloatingPlaceholderTextField(text: $characterFilterOptions.type, placeholder: "Type", isSearcheable: false)
            .frame(height: 40)

        genderPicker(selection: $characterFilterOptions.gender)
    }
}

// MARK: - Location Filter View
extension FilterView {
    @ViewBuilder
    var locationFilterView: some View {
        FloatingPlaceholderTextField(text: $locationsFilterOptions.name, placeholder: "Name", isSearcheable: false)
            .frame(height: 40)

        FloatingPlaceholderTextField(text: $locationsFilterOptions.type, placeholder: "Type", isSearcheable: false)
            .frame(height: 40)

        FloatingPlaceholderTextField(text: $locationsFilterOptions.dimension, placeholder: "Dimension", isSearcheable: false)
            .frame(height: 40)
    }
}

// MARK: - Picker Views
extension FilterView {
    @ViewBuilder
    func statusPicker(selection: Binding<String>) -> some View {
        Picker(selection: selection, label: Text(selection.wrappedValue.isEmpty ? "Select Status" : selection.wrappedValue)) {
            Text("All").tag("")
            Text("Alive").tag("alive")
            Text("Dead").tag("dead")
            Text("Unknown").tag("unknown")
        }
        .pickerStyle(MenuPickerStyle())
        .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder
    func genderPicker(selection: Binding<String>) -> some View {
        Picker(selection: selection, label: Text(selection.wrappedValue.isEmpty ? "Select Gender" : selection.wrappedValue)) {
            Text("All").tag("")
            Text("Female").tag("female")
            Text("Male").tag("male")
            Text("Genderless").tag("genderless")
            Text("Unknown").tag("unknown")
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

            Button("Apply") {
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
            
            Button("Cancel") {
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
        applyFilter: {},
        filterViewType: .character
    )
}
