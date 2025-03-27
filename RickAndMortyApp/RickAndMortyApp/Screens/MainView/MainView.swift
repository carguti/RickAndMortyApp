//
//  MainView.swift
//  RickAndMortyApp
//
//  Created by Carlos Gutiérrez Casado on 23/3/25.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            CharactersView()
                .tabItem {
                    Label("CHARACTERS".localized, systemImage: "person")
                }
            
            LocationsView()
                .tabItem {
                    Label("LOCATIONS".localized, systemImage: "location")
                }
        }
        .accentColor(.black)
    }
}

#Preview {
    MainView()
}
