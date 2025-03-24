//
//  Date+Utils.swift
//  RickAndMortyApp
//
//  Created by Carlos Gutiérrez Casado on 23/3/25.
//

import Foundation

extension  DateFormatter {
    private static let kUTCTimezone = "UTC"
    
    static let localeDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = Locale(identifier: "es_ES")
        
        return dateFormatter
    }()
    
    static func decodeDate(from string: String, using formatter: DateFormatter) -> Date? {
        if let date = formatter.date(from: string) {
            return date
        }
        
        return nil
    }
}
