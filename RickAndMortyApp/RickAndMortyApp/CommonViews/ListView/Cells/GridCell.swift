//
//  GridCell.swift
//  RickAndMortyApp
//
//  Created by Carlos Gutiérrez Casado on 23/3/25.
//

import SwiftUI
import SDWebImageSwiftUI


@MainActor
struct GridCell: View {
    let character: Character
    
    var body: some View {
        ZStack {
            VStack {
                WebImage(url: URL(string: character.image))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(12)
            }
        }
        .ignoresSafeArea()
        .padding(.horizontal, 20)
    }
}

#Preview {
    GridCell(character: Mocks.mockCharacter)
}
