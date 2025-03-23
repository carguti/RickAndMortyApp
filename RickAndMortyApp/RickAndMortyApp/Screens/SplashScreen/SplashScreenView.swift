//
//  SplashScreenView.swift
//  RickAndMortyApp
//
//  Created by Carlos Gutiérrez Casado on 22/3/25.
//

import SwiftUI

struct SplashScreenView: View {
    @StateObject var splashScreenVM = SplashScreenVM()
    
    
    var body: some View {
        if splashScreenVM.initialSynchCompleted {
            ApplicationSwitcher()
        } else {
            content
        }
    }
}

// MARK: - ViewBuilders

extension SplashScreenView {
    @ViewBuilder
    private var content: some View {
        ZStack {
            Text("SplashScreen")
        }
        .onAppear {
            splashScreenVM.doInitialSynch = true
        }
        .onChange(of: splashScreenVM.doInitialSynch, { oldValue, newValue in
            if newValue == true {
                Task {
                    await splashScreenVM.initialSynch()
                }
            }
        })
    }
}

#Preview {
    SplashScreenView()
}
