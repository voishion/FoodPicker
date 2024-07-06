//
//  Unit.swift
//  FoodPicker
//
//  Created by 李露 on 2024/7/6.
//

import SwiftUI

enum Unit: String, CaseIterable, Identifiable, View {
    case gram = "g", pound = "lb"
    
    var id: Self { self }
    
    var body: some View {
        Text(rawValue)
    }
}
