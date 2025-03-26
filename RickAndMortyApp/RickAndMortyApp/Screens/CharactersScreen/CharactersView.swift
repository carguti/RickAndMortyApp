//
//  CharactersView.swift
//  RickAndMortyApp
//
//  Created by Carlos Gutiérrez Casado on 23/3/25.
//

import SwiftUI

struct CharactersView: View {
    @StateObject var charactersVM = CharactersVM()
    @State private var filterOptions = FilterOptions()
    @State private var isFilterPresented = false
    
    @State private var searchText: String = ""
    @State private var gridSize: GridSize = .two
    @State private var selectedCharacter: Character?
    @State private var isSheetPresented = false
    var currentPage: Int = 1
    
    var filteredCharacters: [Character] {
        if searchText.isEmpty {
            return charactersVM.characters
        } else {
            return charactersVM.filterCharacters(searchText: searchText)
        }
    }
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    FloatingPlaceholderTextField(text: $searchText, placeholder: "Search character", isSearcheable: true)
                    
                    Spacer()
                    
                    Button {
                        if let currentIndex = GridSize.allCases.firstIndex(of: gridSize) {
                            let nextIndex = (currentIndex + 1) % GridSize.allCases.count
                            gridSize = GridSize.allCases[nextIndex]
                        }
                    } label: {
                        Image(systemName: gridSize.icon()).imageScale(.large)
                            .foregroundColor(.black)
                            .frame(width: 30)
                    }
                    
                    Button(action: { isFilterPresented = true }) {
                        Image(systemName: "line.horizontal.3.decrease.circle")
                            .imageScale(.large)
                            .foregroundColor(.black)
                            .frame(width: 30)
                    }
                }
                .padding(.horizontal, 24)
                
                
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 2), count: gridSize.rawValue)) {
                        ForEach(filteredCharacters, id: \.id) { item in
                            GridCell(character: item)
                                .onTapGesture {
                                    DispatchQueue.main.async {
                                        self.selectedCharacter = item
                                        self.isSheetPresented = true
                                    }
                                }
                            
                            // Detect when the last item appears
                            if charactersVM.hasMoreResults {
                                ProgressView()
                                    .onAppear {
                                        charactersVM.fetchMoreCharacters()
                                    }
                            }
                        }
                        
                        Spacer()
                            .frame(height: 30)
                    }
                    .animation(.easeInOut, value: gridSize)
                    .padding(.horizontal, 12)
                }
            }
            .padding(.vertical, 40)
            
            
            if isFilterPresented {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture { isFilterPresented = false }
                
                FilterView(
                    filterOptions: $filterOptions,
                    isPresented: $isFilterPresented,
                    applyFilter: {
                        charactersVM.fetchFilteredCharacters(with: filterOptions)
                    }
                )
                .padding()
            }
        }
        .sheet(isPresented: Binding(
            get: { isSheetPresented && selectedCharacter != nil },
            set: { isSheetPresented = $0 }
        )) {
            if let character = selectedCharacter {
                CharacterDetailView(character: character)
            }
        }
        .onAppear {
            Task {
                try await charactersVM.getCharacters()
            }
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
}

#Preview {
    CharactersView()
}
