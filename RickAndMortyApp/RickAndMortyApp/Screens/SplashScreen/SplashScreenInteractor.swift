//
//  SplashScreenInteractor.swift
//  RickAndMortyApp
//
//  Created by Carlos Gutiérrez Casado on 22/3/25.
//

import Foundation

final class SplashScreenInteractor {
    func initialSynch() async throws {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        //Dependencies.shared.provideDependencias()
    }
}
