//
//  DependencyInjector.swift
//  RickAndMortyApp
//
//  Created by Carlos Gutiérrez Casado on 23/3/25.
//

import Foundation

struct DependencyInjector {
    private static var dependencyList: [String:Any] = [:]
    
    // Attempts to retrieve the dependency. If it doesn't exist, it's an error in our logic, so we throw a fatal error.
    static func resolve<T>() -> T {
        guard let t = dependencyList[String(describing: T.self)] as? T else {
            fatalError("No provider registered for type \(T.self)")
        }
        return t
    }
    
    // Creates a "key:value" in a dictionary with the description of T being the key, and T being the actual value.
    static func register<T>(dependency: T) {
        let key = String(describing: T.self)
        
        // Remove existing dependency if it exists
        if dependencyList.keys.contains(key) {
            dependencyList.removeValue(forKey: key)
        }
        
        // Store the dependency as AnyObject
        dependencyList[key] = dependency
    }
}

// Property wrapper to simplify injection
@propertyWrapper struct Inject<T> {
    var wrappedValue: T
    
    init() {
        self.wrappedValue = DependencyInjector.resolve()
        print("Dependency injected <-", String(describing: type(of: self.wrappedValue)))
    }
}

// Property wrapper to simplify providing
@propertyWrapper struct Provider<T> {
    var wrappedValue: T
    
    init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        DependencyInjector.register(dependency: wrappedValue)
        print("Dependency provided ->", String(describing: type(of: self.wrappedValue)))
    }
}

