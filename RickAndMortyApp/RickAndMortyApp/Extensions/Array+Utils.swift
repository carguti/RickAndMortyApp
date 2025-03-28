//
//  Array+Utils.swift
//  RickAndMortyApp
//
//  Created by Carlos Gutiérrez Casado on 28/3/25.
//

import Foundation

extension Array where Element == String {
    func episodeNumbersString() -> String {
        let episodeNumbers = self.compactMap { $0.components(separatedBy: "/").last }
        return episodeNumbers.joined(separator: ", ")
    }
}
