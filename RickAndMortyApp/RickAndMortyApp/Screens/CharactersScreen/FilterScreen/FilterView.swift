//
//  FilterView.swift
//  RickAndMortyApp
//
//  Created by Carlos Gutiérrez Casado on 24/3/25.
//

import SwiftUI

struct FilterView: View {
    @Binding var filterOptions: FilterOptions
    @Binding var isPresented: Bool
    
    var applyFilter: () -> Void
    
    var body: some View {
        VStack(spacing: 40) {
            Text("Filter Characters")
                .font(.title)
                .bold()

            FloatingPlaceholderTextField(text: $filterOptions.name, placeholder: "Name", isSearcheable: false)
                .frame(height: 40)

            Picker(selection: $filterOptions.status, label: Text(filterOptions.status.isEmpty ? "Select Status" : filterOptions.status)) {
                Text("All").tag("")
                Text("Alive").tag("alive")
                Text("Dead").tag("dead")
                Text("Unknown").tag("unknown")
            }
            .pickerStyle(MenuPickerStyle())
            .frame(maxWidth: .infinity)

            FloatingPlaceholderTextField(text: $filterOptions.species, placeholder: "Species", isSearcheable: false)
                .frame(height: 40)
            
            FloatingPlaceholderTextField(text: $filterOptions.type, placeholder: "Type", isSearcheable: false)
                .frame(height: 40)

            Picker(selection: $filterOptions.status, label: Text(filterOptions.status.isEmpty ? "Select Gender" : filterOptions.status)) {
                Text("All").tag("")
                Text("Female").tag("female")
                Text("Male").tag("male")
                Text("Genderless").tag("genderless")
                Text("Unknown").tag("unknown")
            }
            .pickerStyle(MenuPickerStyle())
            .frame(maxWidth: .infinity)

            HStack {
                Button("Cancel") {
                    isPresented = false
                }
                .foregroundColor(.black)

                Spacer()

                Button("Apply") {
                    applyFilter()
                    isPresented = false
                }
                .foregroundColor(.black)
            }
            .padding()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 10)
    }
}

#Preview {
    CharactersView()
}
