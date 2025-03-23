//
//  InitialSynchError.swift
//  RickAndMortyApp
//
//  Created by Carlos Gutiérrez Casado on 22/3/25.
//

import Foundation

enum InitialSynchError: Error {
    case unknown
    case fetchData
    
    var description: String {
        switch self {
        case .unknown:
            return "Unknown initial sync error"
        case .fetchData:
            return "Error detching data"
        }
    }
}
