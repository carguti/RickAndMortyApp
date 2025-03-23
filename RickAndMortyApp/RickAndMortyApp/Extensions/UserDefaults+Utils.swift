//
//  UserDefaults+Utils.swift
//  RickAndMortyApp
//
//  Created by Carlos Gutiérrez Casado on 22/3/25.
//

import Foundation

extension UserDefaults {
     // Set Codable object into UserDefaults or remove it if object is nil
     public func set<T: Codable>(object: T?, forKey: String) {
         guard let object = object else {
             removeObject(forKey: forKey)
             
             synchronize()
             
             return
         }
         
         let jsonData = try! JSONEncoder().encode(object)

         set(jsonData, forKey: forKey)
         
         synchronize()
     }

     // Get Codable object from UserDefaults
     public func get<T: Codable>(objectType: T.Type, forKey: String) -> T? {
         guard let result = value(forKey: forKey) as? Data else {
             return nil
         }

         return try! JSONDecoder().decode(objectType, from: result)
     }
 }

 // MARK: - OnBoarding
 extension UserDefaults {
     struct UserDefaultsOnBoardingKeys {
         static let kOnBoardingShown = "OnBoardingShown"
     }
     
     // MARK: - OnBoarding shown
     var onBoardingShown: Bool {
         get {
             guard let onBoardingShown = get(objectType: Bool.self, forKey: UserDefaultsOnBoardingKeys.kOnBoardingShown) else { return false }
             return onBoardingShown
         }
         
         set {
             set(object: newValue, forKey: UserDefaultsOnBoardingKeys.kOnBoardingShown)
             
             synchronize()
         }
     }
 }
