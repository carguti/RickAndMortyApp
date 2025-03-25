//
//  FloatingPlaceholderTextField.swift
//  RickAndMortyApp
//
//  Created by Carlos Gutiérrez Casado on 23/3/25.
//

import SwiftUI

struct FloatingPlaceholderTextField: View {
    @Binding var text: String
    @FocusState private var isFocused: Bool
    
    var placeholder: String
    var isSearcheable: Bool
    
    var body: some View {
        VStack(spacing: -2) {
            ZStack(alignment: .leading) {
                Text(!isFocused ? placeholder : (isSearcheable ? "Searching..." : placeholder))
                    .foregroundColor(isFocused || !text.isEmpty ? Color.black : Color.black.opacity(0.2))
                    .font(isFocused || !text.isEmpty ? (.system(size: 16, weight: .regular)) : (.system(size: 20, weight: .regular)))
                    .offset(y: isFocused || !text.isEmpty ? -40 : 0)
                    .scaleEffect(isFocused || !text.isEmpty ? 0.9 : 1.0, anchor: .leading)
                    .animation(.easeInOut(duration: 0.3), value: isFocused || !text.isEmpty)
                    .padding(.leading, 12)
                
                HStack {
                    TextField("", text: $text)
                        .padding(12)
                        .focused($isFocused)
                        .frame(height: 50)
                    
                    Button(action: {
                        // Serch functionality
                    }) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.black)
                            .padding(.trailing, 12)
                    }
                    .opacity(isSearcheable ? 1 : 0)
                }
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    FloatingPlaceholderTextField(text: .constant("Rick"), placeholder: "Search character", isSearcheable: true)
}

