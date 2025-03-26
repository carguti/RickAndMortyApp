//
//  Character.swift
//  RickAndMortyApp
//
//  Created by Carlos Gutiérrez Casado on 23/3/25.
//

import Foundation

struct CharacterResponse: Codable {
    let info: ResponseInfo
    let results: [Character]
}

struct Character: Codable, Identifiable {
    let id: Int
    let name: String
    let status: Status
    let species: String
    let type: String
    let gender: String
    let origin: Origin
    let location: CharacterLocation
    let image: String
    let episode: [String]
    let url: String
    let created: Date?
    
    enum CodingKeys: String, CodingKey {
        case id, name, status, species, type, gender, origin, location, image, episode, url, created
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        status = try container.decode(Status.self, forKey: .status)
        species = try container.decode(String.self, forKey: .species)
        type = try container.decode(String.self, forKey: .type)
        gender = try container.decode(String.self, forKey: .gender)
        origin = try container.decode(Origin.self, forKey: .origin)
        location = try container.decode(CharacterLocation.self, forKey: .location)
        image = try container.decode(String.self, forKey: .image)
        episode = try container.decode([String].self, forKey: .episode)
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

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
    case genderless = "Genderless"
    case unknown = "unknown"
}

struct Origin: Codable {
    var name: String
    var url: String
}

struct CharacterLocation: Codable {
    var name: String
    var url: String
}

extension Character {
    init(
        id: Int,
        name: String,
        status: Status,
        species: String,
        type: String,
        gender: String,
        origin: Origin,
        location: CharacterLocation,
        image: String,
        episode: [String],
        url: String,
        created: Date
    ) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = origin
        self.location = location
        self.image = image
        self.episode = episode
        self.url = url
        self.created = created
    }
}
