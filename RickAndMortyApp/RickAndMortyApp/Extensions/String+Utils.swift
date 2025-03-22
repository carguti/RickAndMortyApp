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
