//
//  Location.swift
//  RickAndMortyApp
//
//  Created by Carlos Gutiérrez Casado on 26/3/25.
//

import Foundation

struct LocationResponse: Codable {
    let info: ResponseInfo
    let results: [Location]
}

struct Location: Codable, Identifiable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: Date?
    
    enum CodingKeys: String, CodingKey {
        case id, name, type, dimension, residents, url, created
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        type = try container.decode(String.self, forKey: .type)
        dimension = try container.decode(String.self, forKey: .dimension)
        residents = try container.decode([String].self, forKey: .residents)
        url = try container.decode(String.self, forKey: .url)
        
        if let createdDateStr = try container.decodeIfPresent(String.self, forKey: .created) {
            if let date = DateFormatter.decodeDate(from: createdDateStr, using: DateFormatter.localeDateFormatter) {
                created = date
            } else {
                throw DecodingError.dataCorruptedError(forKey: .created,
                                                       in: container,
                                                       debugDescription: "Created date string \(createdDateStr) does not match fexpeted format")
            }
        } else {
            created = nil
        }
    }
}

extension Location {
    init(
        id: Int,
        name: String,
        type: String,
        dimension: String,
        residents: [String],
        url: String,
        created: Date
    ) {
        self.id = id
        self.name = name
        self.type = type
        self.dimension = dimension
        self.residents = residents
        self.url = url
        self.created = created
    }
}
