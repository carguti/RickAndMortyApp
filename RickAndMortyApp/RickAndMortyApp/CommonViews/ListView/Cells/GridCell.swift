//
//  GridCell.swift
//  RickAndMortyApp
//
//  Created by Carlos Gutiérrez Casado on 23/3/25.
//

import SwiftUI

@MainActor
struct GridCell: View {
    let character: Character
    
    var body: some View {
        ZStack {
            VStack {
                if character.image.isEmpty {
                    Image("Placeholder")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 54, height: 54)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                } else if let imageURL = URL(string: character.image) {
                    AsyncImage(url: imageURL) { image in
                        image.resizable()
                    } placeholder: {
                        Image("Placeholder")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 54, height: 54)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .aspectRatio(contentMode: .fit)
                } else {
                    Image("Placeholder")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 54, height: 54)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
        }
        .ignoresSafeArea()
        .padding(.horizontal, 20)
    }
}

#Preview {
    GridCell(character: Mocks.mockCharacter)
}
