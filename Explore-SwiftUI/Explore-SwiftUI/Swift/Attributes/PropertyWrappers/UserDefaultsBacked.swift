//
//  UserDefaultsBacked.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 08/11/22.
//

import Foundation
import UIKit
import MapKit

@propertyWrapper
struct UserDefaultsBacked<Value> {
    
    var wrappedValue: Value {
        get {
            let value = storage.value(forKey: key) as? Value
            return value ?? defaultValue
        }
        set {
            storage.set(newValue, forKey: key)
        }
    }
    
    private let key: String
    private let defaultValue: Value
    private var storage: UserDefaults
    
    init(
        wrappedValue defaultValue: Value,
        key: String,
        storage: UserDefaults = .standard
    ) {
        self.defaultValue = defaultValue
        self.key = key
        self.storage = storage
    }
}
extension UserDefaultsBacked where Value: ExpressibleByNilLiteral {
    init(key: String, storage: UserDefaults) {
        self.init(wrappedValue: nil, key: key, storage: storage)
    }
}

private protocol AnyOptional {
    var isNil: Bool {get}
}
extension Optional: AnyOptional {
    var isNil: Bool {
        self == nil
    }
}
