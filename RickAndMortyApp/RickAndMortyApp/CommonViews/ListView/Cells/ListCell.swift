//
//  ListCell.swift
//  RickAndMortyApp
//
//  Created by Carlos Gutiérrez Casado on 23/3/25.
//

import SwiftUI

struct ListCell: View {
    let location: Location
    
    var body: some View {
        ZStack {
            Text(location.name)
                .font(.system(size: 20, weight: .bold))
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ListCell(location: Mocks.mockLocation)
}
