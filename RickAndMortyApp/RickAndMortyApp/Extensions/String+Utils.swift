//
//  String+Utils.swift
//  RickAndMortyApp
//
//  Created by Carlos Gutiérrez Casado on 22/3/25.
//

import Foundation

extension String {
    var ns: NSString { return self as NSString }
    
    func appendingPathComponent(_ path: String) -> String {
        return self.ns.appendingPathComponent(path)
    }
}

extension String {
    func extractPageNumber() -> Int? {
        guard let url = URL(string: self),
              let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let pageItem = components.queryItems?.first(where: { $0.name == "page" }),
              let pageNumber = Int(pageItem.value ?? "") else {
            return nil
        }
        return pageNumber
    }
}

extension String {
    func extractCharacterNumber() -> Int? {
        let components = self.split(separator: "/")
        if let lastComponent = components.last, let number = Int(lastComponent) {
            return number
        }
        return nil
    }
}

