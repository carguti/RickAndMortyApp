//
//  ResultViewMode.swift
//  RickAndMortyApp
//
//  Created by Carlos Gutiérrez Casado on 23/3/25.
//

import Foundation

enum GridSize: Int, CaseIterable {
    case two = 2
    case three = 3
    case four = 4
    
    func icon() -> String {
        switch self {
        case .two:
            return "square.grid.3x2"
        case .three:
            return "square.grid.3x3"
        case .four:
            return "square.grid.2x2"
        }
    }
}
