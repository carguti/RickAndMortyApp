//
//  Bundle+Utils.swift
//  RickAndMortyApp
//
//  Created by Carlos Gutiérrez Casado on 23/3/25.
//

import Foundation

extension Bundle {
    public static func string(for key: String) -> String? {
        return Bundle.main.object(forInfoDictionaryKey: key) as? String
    }
}
