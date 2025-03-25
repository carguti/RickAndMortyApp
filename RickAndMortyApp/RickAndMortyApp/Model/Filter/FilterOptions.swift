//
//  FilterOptions.swift
//  RickAndMortyApp
//
//  Created by Carlos Gutiérrez Casado on 25/3/25.
//

import Foundation

struct FilterOptions {
    var name: String = ""
    var status: String = ""
    var species: String = ""
    var type: String = ""
    var gender: String = ""
}


extension FilterOptions {
    var queryString: String {
        var queryItems = [URLQueryItem]()
        
        if !name.isEmpty {
            queryItems.append(URLQueryItem(name: "name", value: name))
        }
        if !status.isEmpty {
            queryItems.append(URLQueryItem(name: "status", value: status))
        }
        if !species.isEmpty {
            queryItems.append(URLQueryItem(name: "species", value: species))
        }
        if !type.isEmpty {
            queryItems.append(URLQueryItem(name: "type", value: type))
        }
        if !gender.isEmpty {
            queryItems.append(URLQueryItem(name: "gender", value: gender))
        }
        
        var components = URLComponents()
        components.queryItems = queryItems
        
        return components.url?.query ?? ""
    }
}
