//
//  ResponseInfo.swift
//  RickAndMortyApp
//
//  Created by Carlos Gutiérrez Casado on 23/3/25.
//

import Foundation

struct ResponseInfo: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
