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
            Text("OnBoarding View")
            
            Button {
                onBoardingVM.updateFirstLaunch()
            } label: {
                Text("Lo tengo!")
            }

        }
        
        
    }
    
}

#Preview {
    OnBoardingView()
}
