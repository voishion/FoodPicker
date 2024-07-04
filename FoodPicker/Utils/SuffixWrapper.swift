//
//  SuffixWrapper.swift
//  FoodPicker
//
//  Created by 李露 on 2024/6/19.
//

/// 后缀包装器
@propertyWrapper struct Suffix: Equatable {
    var wrappedValue: Double
    private let suffix: String
    
    init(wrappedValue: Double, _ suffix: String) {
        self.wrappedValue = wrappedValue
        self.suffix = suffix
    }
    
    var projectedValue: String {
        wrappedValue.formatted() + " \(suffix)"
    }
}
