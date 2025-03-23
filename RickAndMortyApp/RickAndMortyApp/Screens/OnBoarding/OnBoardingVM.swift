//
//  OnBoardingVM.swift
//  RickAndMortyApp
//
//  Created by Carlos Gutiérrez Casado on 23/3/25.
//

import Foundation

final class OnBoardingVM: ObservableObject {
    func updateFirstLaunch() {
        UserDefaults.standard.onBoardingShown = true
    }
}
