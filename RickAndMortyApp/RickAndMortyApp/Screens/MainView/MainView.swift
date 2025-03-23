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
                    Label("Characters", systemImage: "list.dash")
                }
            
            LocationsView()
                .tabItem {
                    Label("Locations", systemImage: "list.dash")
                }
            
            EpisodesView()
                .tabItem {
                    Label("Episodes", systemImage: "list.dash")
                }
            
            
            FavsView()
                .tabItem {
                    Label("Favs", systemImage: "list.dash")
                }
        }
    }
}

#Preview {
    MainView()
}
