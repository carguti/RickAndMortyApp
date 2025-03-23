//
//  SplashScreenVM.swift
//  RickAndMortyApp
//
//  Created by Carlos Gutiérrez Casado on 22/3/25.
//

import Foundation
import SwiftUI

final class SplashScreenVM: NSObject, ObservableObject {
    @Published var synchronizing = false
    @Published var initialSynchCompleted = false
    @Published var initialSynchFailed = false
    @Published var initialSynchError: InitialSynchError? = nil
    @Published var doInitialSynch = false
    
    private let interactor = SplashScreenInteractor()
    
    @MainActor func initialSynch() async {
        synchronizing = true
        
        do {
            try await interactor.initialSynch()
        } catch let synchError as InitialSynchError {
            print("Error doing initial synch: \(synchError)")
            
            initialSynchError = synchError
        } catch {
            print("Error doing initial synch: \(error)")
            
            initialSynchError = .unknown
        }
        
        initialSynchFinished()
    }
    
    //MARK: - Private methods
    
    private func initialSynchFinished() {
        initialSynchCompleted = initialSynchError == nil
        initialSynchFailed = !initialSynchCompleted
        synchronizing = false
    }
}
