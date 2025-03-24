//
//  GridCell.swift
//  RickAndMortyApp
//
//  Created by Carlos Gutiérrez Casado on 23/3/25.
//

import SwiftUI

struct GridCell: View {
    let character: Character
    
    var body: some View {
        ZStack {
            VStack {
                if character.image.isEmpty {
                    Image("Placeholder")
                        .resizable()
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .aspectRatio(contentMode: .fit)
                } else if let imageURL = URL(string: character.image) {
                    AsyncImage(url: imageURL) { image in
                        image.resizable()
                    } placeholder: {
                        Image("Placeholder")
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .aspectRatio(contentMode: .fit)
                } else {
                    Image("Placeholder")
                        .resizable()
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .aspectRatio(contentMode: .fit)
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
