//
//  Localizable.swift
//  RickAndMortyApp
//
//  Created by Carlos Gutiérrez Casado on 27/3/25.
//

import Foundation

protocol Localizable {
    var localized: String { get }
}

extension String: Localizable {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
