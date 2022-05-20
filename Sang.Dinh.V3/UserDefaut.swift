//
//  UserDefaut.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 18/05/2022.
//

import UIKit
import Foundation
import Darwin

var greeting = "Hello, playground"

class UserDefault {
    
    // Define Signleton
    static let shared = UserDefault()
    private init() {}
    
    // Private properties
    private let standard = UserDefaults.standard
    
    // Helper for base data type
    func setValue(_ value: Any?, forKey: String) {
        standard.set(value, forKey: forKey)
    }
    
    func getValue(forKey: String) -> Any? {
        standard.value(forKey: forKey)
    }
    
    // Helper for custom object
    func saveObject<T: Codable>(_ value: T?, forKey: String) {
        let encoder = JSONEncoder()
        if let data: Data = try? encoder.encode(value) {
            standard.set(data, forKey: forKey)
        }
    }
    
    func saveObjects<T: Codable>(_ value: [T]?, forKey: String) {
        let encoder = JSONEncoder()
        if let data: Data = try? encoder.encode(value) {
            standard.set(data, forKey: forKey)
        }
    }
    
    func getObject<T: Codable>(type: T.Type, key: String) -> T? {
        let decoder = JSONDecoder()
        if let data = standard.value(forKey: key) as? Data {
            let result = try? decoder.decode(T.self, from: data)
            return result
        }
        return nil
    }
    
    func getObjects<T: Codable>(type: T.Type, key: String) -> [T] {
        let decoder = JSONDecoder()
        if let data = standard.value(forKey: key) as? Data {
            let result = try? decoder.decode([T].self, from: data)
            return result ?? []
        }
        return []
    }
}
