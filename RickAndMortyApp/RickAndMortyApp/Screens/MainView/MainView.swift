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
                    Label("Characters", systemImage: "person")
                }
            
            LocationsView()
                .tabItem {
                    Label("Locations", systemImage: "location")
                }
            
            EpisodesView()
                .tabItem {
                    Label("Episodes", systemImage: "play.square.stack")
                }
        }
        .accentColor(.black)
    }
}

#Preview {
    MainView()
}
