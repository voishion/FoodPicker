//
//  SuffixWrapper.swift
//  FoodPicker
//
//  Created by 李露 on 2024/6/19.
//

/// 后缀包装器
@propertyWrapper struct Suffix<Unit: MyUnitProtocol & Equatable>: Equatable {
    var wrappedValue: Double
    var unit: Unit
    
    init(wrappedValue: Double, _ unit: Unit) {
        self.wrappedValue = wrappedValue
        self.unit = unit
    }
    
    var projectedValue: Self {
        get { self }
        set { self = newValue }
    }
    
    var description: String {
        wrappedValue.formatted(.number.precision(.fractionLength(0...1))) + " " + unit.rawValue
    }
}

extension Suffix: Codable { }
