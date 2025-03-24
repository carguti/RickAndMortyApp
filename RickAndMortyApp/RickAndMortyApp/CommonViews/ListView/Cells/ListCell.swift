//
//  ListCell.swift
//  RickAndMortyApp
//
//  Created by Carlos Gutiérrez Casado on 23/3/25.
//

import SwiftUI

struct ListCell: View {
    let character: Character
    
    var body: some View {
        ZStack {
            VStack {
                Text(character.name)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(Color.black)
                
                AsyncImage(url: URL(string: character.image)) { image in
                    image.resizable()
                } placeholder: {
                    
                }
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .aspectRatio(contentMode: .fit)
            }
        }
        .ignoresSafeArea()
        .padding(.horizontal, 20)
    }
}

#Preview {
    ListCell(character: Mocks.mockCharacter)
}
