//
//  Food.swift
//  FoodPicker
//
//  Created by 李露 on 2024/6/16.
//

import SwiftUI

typealias Energy = Suffix<MyEnergyUnit>
typealias Weight = Suffix<MyWeightUnit>

struct Food: Equatable, Identifiable {
    var id = UUID()
    var name: String
    var image: String
    @Energy var calorie: Double
    @Weight var carb: Double
    @Weight var fat: Double
    @Weight var protein: Double
}

// MARK: static
extension Food {
    static var new: Food {
        @AppStorage(.preferredEnergyUnit) var preferredEnergyUnit: MyEnergyUnit = .cal
        @AppStorage(.preferredWieghtUnit) var preferredWieghtUnit: MyWeightUnit = .gram
        
        return Food(name: "", image: "",
             calorie: .init(wrappedValue: .zero, preferredEnergyUnit),
             carb: .init(wrappedValue: .zero, preferredWieghtUnit),
             fat: .init(wrappedValue: .zero, preferredWieghtUnit),
             protein: .init(wrappedValue: .zero, preferredWieghtUnit)
        )
    }
    
    private init(id: UUID = UUID(), name: String, image: String, calorie: Double, carb: Double, fat: Double, protein: Double) {
        self.id = id
        self.name = name
        self.image = image
        self._calorie = .init(wrappedValue: calorie, .cal)
        self._carb    = .init(wrappedValue: carb, .gram)
        self._fat     = .init(wrappedValue: fat, .gram)
        self._protein = .init(wrappedValue: protein, .gram)
    }
    
    
    static let examples = [
        Food(name: "汉堡", image: "🍔", calorie: 294, carb: 14, fat: 24, protein: 17),
        Food(name: "沙拉", image: "🥗", calorie: 89, carb: 20, fat: 0, protein: 1.8),
        Food(name: "披萨", image: "🍕", calorie: 266, carb: 33, fat: 10, protein: 11),
        Food(name: "意大利面", image: "🍝", calorie: 339, carb: 74, fat: 1.1, protein: 12),
        Food(name: "鸡腿便当", image: "🍗🍱", calorie: 191, carb: 19, fat: 8.1, protein: 11.7),
        Food(name: "刀削面", image: "🍜", calorie: 256, carb: 56, fat: 17, protein: 22),
        Food(name: "火锅", image: "🍲", calorie: 233, carb: 26.5, fat: 17, protein: 22),
        Food(name: "牛肉面", image: "🐄🍜", calorie: 219, carb: 33, fat: 5, protein: 9),
        Food(name: "关东煮", image: "🥘", calorie: 80, carb: 4, fat: 4, protein: 6),
    ]

}

extension Food: Codable { }
