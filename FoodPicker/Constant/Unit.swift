//
//  Unit.swift
//  FoodPicker
//
//  Created by 李露 on 2024/7/6.
//

import SwiftUI

protocol MyUnitProtocol: Codable, Identifiable, CaseIterable, View, RawRepresentable where RawValue == String, AllCases: RandomAccessCollection {
    
}

enum MyEnergyUnit: String, MyUnitProtocol {
    case cal = "大卡"
}

enum MyWeightUnit: String, MyUnitProtocol {
    case gram = "g", pound = "lb"
}

extension MyUnitProtocol {
    var body: some View {
        Text(rawValue)
    }
}

extension MyUnitProtocol {
    var id: Self { self }
}
