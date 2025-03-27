//
//  ListCell.swift
//  RickAndMortyApp
//
//  Created by Carlos Gutiérrez Casado on 23/3/25.
//

import SwiftUI

struct ListCell: View {
    let location: Location
    @StateObject var locationsDetailVM = LocationDetailVM()
    @Binding var expandedLocationId: Int?
    
    var isExpanded: Bool {
        expandedLocationId == location.id
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(location.name)
                    .font(.headline)
                
                Spacer()
                
                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                    .foregroundColor(.black)
            }
            
            if isExpanded {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Type: ")
                        .foregroundColor(Color.black.opacity(0.7))
                    + Text(location.type)
                        .foregroundColor(.gray)
                    Text("Dimension: ")
                        .foregroundColor(Color.black.opacity(0.7))
                    + Text(location.dimension)
                        .foregroundColor(.gray)
                    Text("Residents in \(location.name)")
                        .foregroundColor(Color.black.opacity(0.7))
                    
                    Text(locationsDetailVM.namesString)
                        .padding(.leading, 12)
                        .foregroundColor(.gray)
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .onTapGesture {
            withAnimation {
                if isExpanded {
                    expandedLocationId = nil
                } else {
                    expandedLocationId = location.id
                    Task {
                        try await locationsDetailVM.getCharacters(from: location)
                    }
                }
            }
        }
    }
}

#Preview {
    ListCell(location: Mocks.mockLocation, expandedLocationId: .constant(1))
}
