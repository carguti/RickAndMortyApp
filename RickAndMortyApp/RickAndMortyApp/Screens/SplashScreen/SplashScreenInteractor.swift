//
//  SplashScreenInteractor.swift
//  RickAndMortyApp
//
//  Created by Carlos Gutiérrez Casado on 22/3/25.
//

import Foundation


final class SplashScreenInteractor {
    @MainActor
    func initialSynch() async throws {
        let _ = Dependencies.create(testMode: false)
        
        @Inject var baseApiWebRepository: BaseApiWebRepository
        @Inject var baseApiDBRepository: BaseApiDBRepository
        
        let baseApi = try await baseApiWebRepository.getBaseApi()
        try baseApiDBRepository.store(baseApi: baseApi)
    }
}
