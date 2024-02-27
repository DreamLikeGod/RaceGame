//
//  UserDefaults+Extension.swift
//  RaceGame
//
//  Created by Егор on 13.02.2024.
//

import Foundation

extension UserDefaults {
    
    func set<T: Encodable>(_ encodable: T, forKey: String) {
        if let data = try? JSONEncoder().encode(encodable) {
            setValue(data, forKey: forKey)
        }
    }
    func value<T: Decodable>(with type: T.Type, forKey: String) -> T? {
        if let data = object(forKey: forKey) as? Data,
           let result = try? JSONDecoder().decode(type, from: data) {
            return result
        }
        return nil
    }
    
}
