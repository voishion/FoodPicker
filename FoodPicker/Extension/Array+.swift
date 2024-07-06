//
//  Array+.swift
//  FoodPicker
//
//  Created by 李露 on 2024/7/6.
//

import SwiftUI

extension Array: RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let array = try? JSONDecoder().decode(Self.self, from: data) else { return nil }
        self = array
    }
    
    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let string = String(data: data, encoding: .utf8) else { return "" }
        return string
    }
}
