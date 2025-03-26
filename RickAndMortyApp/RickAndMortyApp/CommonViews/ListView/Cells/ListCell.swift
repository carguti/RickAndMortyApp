//
//  ListCell.swift
//  RickAndMortyApp
//
//  Created by Carlos Gutiérrez Casado on 23/3/25.
//

import SwiftUI

struct ListCell: View {
    let location: Location
    @State private var isExpanded: Bool = false
    
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
                    Text("Type: \(location.type)")
                    Text("Dimension: \(location.dimension)")
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
                isExpanded.toggle()
            }
        }
        .padding(.top, 24)
    }
}

#Preview {
    ListCell(location: Mocks.mockLocation)
}
