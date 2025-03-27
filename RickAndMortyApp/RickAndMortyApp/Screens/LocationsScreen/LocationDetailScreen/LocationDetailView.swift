//
//  LocationDetailView.swift
//  RickAndMortyApp
//
//  Created by Carlos Gutiérrez Casado on 26/3/25.
//

import SwiftUI

struct LocationDetailView: View {
    @StateObject var locationsDetailVM = LocationDetailVM()
    
    let location: Location
    
    var charactersNames: [String] = []
    var charactersResidents: [Character] = []
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Text(location.name)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(Color.black)
                
                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 20) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Type: \(location.type)".capitalized)
                                .font(.system(size: 16, weight: .regular))
                                .foregroundStyle(Color.black)
                            
                            Text("Dimension: \(location.dimension)".capitalized)
                                .font(.system(size: 16, weight: .regular))
                                .foregroundStyle(Color.black)
                            
                            HStack {
                                Text("Residents: \(location.dimension)".capitalized)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundStyle(Color.black)
                                
                                Text(locationsDetailVM.namesString)
                            }
                        }
                    }
                }
            }
        }
        .ignoresSafeArea()
        .padding(.horizontal, 20)
        .onAppear {
            Task {
                try await locationsDetailVM.getCharacters(from: location)
            }
        }
    }
    
}

#Preview {
    LocationDetailView(location: Mocks.mockLocation)
}
