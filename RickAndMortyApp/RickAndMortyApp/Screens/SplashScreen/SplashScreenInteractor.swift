//
//  SplashScreenInteractor.swift
//  RickAndMortyApp
//
//  Created by Carlos Gutiérrez Casado on 22/3/25.
//

import Foundation

final class SplashScreenInteractor {
    @Inject var baseApiWebRepository: BaseApiWebRepository
    @Inject var baseApiDBRepository: BaseApiDBRepository
    
    func initialSynch() async throws {
        Task {
            let baseApi = try await baseApiWebRepository.getBaseApi()
            try baseApiDBRepository.store(baseApi: baseApi)
        }
    }
}
