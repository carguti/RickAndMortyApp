//
//  OnBoardingView.swift
//  RickAndMortyApp
//
//  Created by Carlos Gutiérrez Casado on 23/3/25.
//

import SwiftUI

struct OnBoardingView: View {
    @StateObject var onBoardingVM = OnBoardingVM()
    var body: some View {
        content
    }
}

extension OnBoardingView {
    @ViewBuilder
    private var content: some View {
        VStack {
            Image("SplashScreenBg")
                .resizable()
                .ignoresSafeArea()
                .aspectRatio(contentMode: .fill)
        }
        .onAppear {
            onBoardingVM.updateFirstLaunch()
        }
    }
    
}

#Preview {
    OnBoardingView()
}
