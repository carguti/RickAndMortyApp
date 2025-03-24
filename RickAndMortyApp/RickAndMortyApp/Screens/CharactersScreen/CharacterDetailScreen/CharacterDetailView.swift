//
//  CharacterDetailView.swift
//  RickAndMortyApp
//
//  Created by Carlos Gutiérrez Casado on 23/3/25.
//

import SwiftUI

struct CharacterDetailView: View {
    let character: Character
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Text(character.name)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(Color.black)
                
                VStack(spacing: 20) {
                    AsyncImage(url: URL(string: character.image)) { image in
                        image.resizable()
                    } placeholder: {
                        
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .aspectRatio(contentMode: .fit)
                    
                    VStack(alignment: .leading, spacing: 20) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Species: \(character.species)".capitalized)
                                .font(.system(size: 16, weight: .regular))
                                .foregroundStyle(Color.black)
                            
                            Text("Status: \(character.status)".capitalized)
                                .font(.system(size: 16, weight: .regular))
                                .foregroundStyle(Color.black)
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Last known location:")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundStyle(Color.black.opacity(0.5))
                            
                            Text("\(character.location.name)".capitalized)
                                .font(.system(size: 16, weight: .regular))
                                .foregroundStyle(Color.black)
                        }
                        
                        VStack(alignment: .leading) {
                            Text("First seen in:")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundStyle(Color.black.opacity(0.5))
                            
                            Text("\(character.episode.first ?? "Maybe an upcoming character?")".capitalized)
                                .font(.system(size: 16, weight: .regular))
                                .foregroundStyle(Color.black)
                        }
                        
                    }
                }
            }
        }
        .ignoresSafeArea()
        .padding(.horizontal, 20)
    }
}

#Preview {
    CharacterDetailView(character: Mocks.mockCharacter)
}
