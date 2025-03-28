//
//  ApplicationSwitcher.swift
//  RickAndMortyApp
//
//  Created by Carlos Gutiérrez Casado on 22/3/25.
//

import SwiftUI

struct ApplicationSwitcher: View {
    @MainActor
    var body: some View {
        if (UserDefaults.standard.baseApi == nil) {
             OnBoardingView()
        } else {
             MainView()
        }
    }
}
